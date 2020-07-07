
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

enum ResponseError: Error {
    case requestUnsucessful
    case unexpectedResponseStructure
}

func authHeaderValue(for token: String) -> String {
    let authorisationValue = Data("\(token):x-oauth-basic".utf8).base64EncodedString()
    return "Basic \(authorisationValue)"
}

func createIssue(inRepo repo: String,
                 forUser user: String,
                 title: String,
                 body: String?,
                 completionHandler: @escaping ([String: Any]?, Error?) -> Void) {
    
    // Create the URL and Request
    
    let urlString = "https://api.github.com/repos/\(user)/\(repo)/issues"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    let authorisationValue = authHeaderValue(for: <#your personal access token#>)
    request.setValue(authorisationValue, forHTTPHeaderField: "Authorization")
    
    // Put the issue information into the JSON structure required
    var json = ["title": title]
    
    if let body = body {
        json["body"] = body
    }
    
    // Serialise the json into Data. We can use try! as we know it is valid JSON, the try will fail
    // if the provided JSON object contains elements that aren't valid JSON.
    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    request.httpBody = jsonData
    
    let task = session.dataTask(with: request) { (data, response, error) in
        
        guard let jsonData = data else {
            completionHandler(nil, ResponseError.requestUnsucessful)
            return
        }
        
        do {
            // Deserialisation can throw an error, so we have to `try` and catch errors
            let deserialised = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            // As `deserialised` has type `Any` we need to cast
            guard let createdIssue = deserialised as? [String: Any] else {
                completionHandler(nil, ResponseError.unexpectedResponseStructure)
                return
            }
            
            completionHandler(createdIssue, nil)
            
        } catch {
            completionHandler(nil, error)
        }
    }
    task.resume()
}

createIssue(inRepo: "BeyondTheStandardLibrary",
            forUser: "SwiftProgrammingCookbook",
            title: <#The title of your feedback#>,
            body: <#Extra detail#>) { (issue, error) in
                
                if let issue = issue {
                    print(issue)
                } else if let error = error {
                    print(error)
                }
}
