
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

func fetchRepos(forUsername username: String,
                completionHandler: @escaping ([[String: Any]]?, Error?) -> Void) {
    
    let urlString = "https://api.github.com/users/\(username)/repos"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    let task = session.dataTask(with: request) { (data, response, error) in
        
        // Once we have handled this response, the Playground
        // can finish executing.
        defer {
            PlaygroundPage.current.finishExecution()
        }
        
        // First unwrap the optional data
        guard let jsonData = data else {
            // If it is nil, there was probably a network error
            completionHandler(nil, ResponseError.requestUnsucessful)
            return
        }
        
        do {
            // Deserialisation can throw an error, so we have to `try` and catch errors
            let deserialised = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            // As `deserialised` has type `Any` we need to cast
            guard let repos = deserialised as? [[String: Any]] else {
                completionHandler(nil, ResponseError.unexpectedResponseStructure)
                return
            }
            
            completionHandler(repos, nil)
            
        } catch {
            completionHandler(nil, error)
        }
    }
    task.resume()
}

enum ResponseError: Error {
    case requestUnsucessful
    case unexpectedResponseStructure
}

fetchRepos(forUsername: "keefmoon") { (repos, error) in
    
    if let repos = repos {
        print(repos)
    } else if let error = error {
        print(error)
    }
}
