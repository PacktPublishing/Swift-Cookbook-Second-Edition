
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct NewsArticle {
    let title: String
    let url: URL
}

func fetchBBCNewsRSSFeed(completion: @escaping ([NewsArticle]?, Error?) -> Void) {
    
    let session = URLSession.shared
    let url = URL(string: "http://feeds.bbci.co.uk/news/rss.xml")!
    let dataTask = session.dataTask(with: url) { (data, response, error) in
        
        guard let data = data, error == nil else {
            completion(nil, error)
            return
        }
        
        let parser = XMLParser(data: data)
        let articleBuilder = RSSNewsArticleBuilder()
        parser.delegate = articleBuilder
        parser.parse()
        let articles = articleBuilder.articles
        completion(articles, nil)
    }
    dataTask.resume()
}

class RSSNewsArticleBuilder: NSObject, XMLParserDelegate {
    
    var inItem = false
    var inTitle = false
    var inLink = false
    var titleData: Data?
    var linkString: String?
    var articles = [NewsArticle]()
    
    func parserDidStartDocument(_ parser: XMLParser) {
        inItem = false
        inTitle = false
        inLink = false
        titleData = nil
        linkString = nil
        articles = [NewsArticle]()
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
            
        case "item":
            inItem = true
            
        case "title":
            inTitle = true
            titleData = Data()
            
        case "link":
            inLink = true
            linkString = ""
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        switch elementName {
            
        case "item":
            inItem = false
            
            guard
                let titleData = titleData,
                let titleString = String(data: titleData, encoding: .utf8),
                let linkString = linkString,
                let link = URL(string: linkString)
                else { break }
            
            let article = NewsArticle(title: titleString, url: link)
            articles.append(article)
            
        case "title":
            inTitle = false
            
        case "link":
            inLink = false
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        
        if inTitle {
            titleData?.append(CDATABlock)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if inLink {
            linkString?.append(string)
        }
    }
}

fetchBBCNewsRSSFeed() { (articles, error) in
    
    if let articles = articles {
        print(articles)
    } else if let error = error {
        print(error)
    }
}
