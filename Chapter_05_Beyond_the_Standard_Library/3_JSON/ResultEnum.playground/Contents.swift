
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

enum ResponseError: Error {
    case requestUnsucessful
    case unexpectedResponseStructure
}

enum Result<SuccessType> {
    case success(SuccessType)
    case failure(Error)
}

func authHeaderValue(for token: String) -> String {
    let authorisationValue = Data("\(token):x-oauth-basic".utf8).base64EncodedString()
    return "Basic \(authorisationValue)"
}

func fetchRepos(forUsername username: String,
                completionHandler: @escaping (Result<[[String: Any]]>) -> Void) {
    
    let urlString = "https://api.github.com/users/\(username)/repos"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.setValue("application/vnd.github.v3+json",
                     forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request) { (data, response, error) in
        
        // Once we have handled this response, the Playground
        // can finish executing.
        defer {
            PlaygroundPage.current.finishExecution()
        }
        
        // First unwrap the optional data
        guard let jsonData = data else {
            // If it is nil, there was probably a network error
            completionHandler(.failure(ResponseError.requestUnsucessful))
            return
        }
        
        do {
            // Deserialisation can throw an error,
            // so we have to `try` and catch errors
            let deserialised = try JSONSerialization.jsonObject(with: jsonData,
                                                                options: [])
            
            // As `deserialised` has type `Any` we need to cast
            guard let repos = deserialised as? [[String: Any]] else {
                let error = ResponseError.unexpectedResponseStructure
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.success(repos))
            
        } catch {
            completionHandler(.failure(error))
        }
    }
    task.resume()
}

func createIssue(inRepo repo: String,
                 forUser user: String,
                 title: String,
                 body: String?,
                 completionHandler: @escaping (Result<[String: Any]>) -> Void) {
    
    // Create the URL and Request
    
    let urlString = "https://api.github.com/repos/\(user)/\(repo)/issues"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let authorisationValue = authHeaderValue(for: <#your personal access token#>)
    request.setValue(authorisationValue, forHTTPHeaderField: "Authorization")
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    
    // Put the issue information into the JSON structure required
    var json = ["title": title]
    
    if let body = body {
        json["body"] = body
    }
    
    // Serialise the json into Data. We can use try! as we know it is valid JSON,
    // the try will fail if the provided JSON object contains elements that
    // aren't valid JSON.
    let jsonData = try! JSONSerialization.data(withJSONObject: json,
                                               options: .prettyPrinted)
    request.httpBody = jsonData
    
    let task = session.dataTask(with: request) { (data, response, error) in
        
        guard let jsonData = data else {
            completionHandler(.failure(ResponseError.requestUnsucessful))
            return
        }
        
        do {
            // Deserialisation can throw an error,
            // so we have to `try` and catch errors
            let deserialised = try JSONSerialization.jsonObject(with: jsonData,
                                                                options: [])
            
            // As `deserialised` has type `Any` we need to cast
            guard let createdIssue = deserialised as? [String: Any] else {
                let error = ResponseError.unexpectedResponseStructure
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.success(createdIssue))
            
        } catch {
            completionHandler(.failure(error))
        }
    }
    task.resume()
}

fetchRepos(forUsername: "SwiftProgrammingCookbook", completionHandler: { result in
    switch result {
    case .success(let repos):
        print(repos)
        
    case .failure(let error):
        print(error)
    }
})

createIssue(inRepo: "BeyondTheStandardLibrary",
            forUser: "SwiftProgrammingCookbook",
            title: <#The title of your feedback#>,
            body: <#Extra detail#>) { result in

                switch result {
                case .success(let issue):
                    print(issue)

                case .failure(let error):
                    print(error)
                }
}
