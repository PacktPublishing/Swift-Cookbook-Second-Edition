import UIKit
import PlaygroundSupport


//PlaygroundPage.current.needsIndefiniteExecution = true

class TableViewController: UITableViewController {
    
    var quotes = [String]()
    var session = URLSession.shared
    
    override func viewDidLoad() {
        fetchQuotes { (response) in
            
            guard let quotes = response as? [Response] else { return }
            for item in quotes {
                self.quotes.append(item.quote)
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = quotes[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = quote
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func fetchQuotes(completionHandler: @escaping ([Response]?) -> Void) -> URLSessionDataTask? {
        
        let urlString = "https://api.bobross.dev/api/10"
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // First unwrap the optional data
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(RootResponse.self, from: data)
                completionHandler(responseObject.response)
                
            } catch {
                completionHandler(nil)
            }
            
        }
        
        task.resume()
        return task
        
    }
    
}
    
PlaygroundPage.current.liveView = TableViewController()
