//
//  ReposTableViewController.swift
//  CocoaTouchExample
//
//  Created by Keith Moon on 07/12/2016.
//  Copyright © 2016 Keith Moon. All rights reserved.
//

import UIKit
import SafariServices
import Dispatch

struct Repo {
    let name: String
    let url: URL
}

enum FetchReposResult {
    case success([Repo])
    case failure(Error)
}

enum ResponseError: Error {
    case requestUnsucessful
    case unexpectedResponseStructure
}

class ReposTableViewController: UITableViewController {

    @IBOutlet var textField: UITextField!
    
    let session = URLSession.shared
    var repos = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repos"
        
//        let repo1 = Repo(name: "Test repo 1", url: URL(string: "http://example.com/repo1")!)
//        let repo2 = Repo(name: "Test repo 2", url: URL(string: "http://example.com/repo2")!)
//        repos.append(repo1)
//        repos.append(repo2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRepo = repos[indexPath.row]
        let repoURL = selectedRepo.url
        let webViewController = SFSafariViewController(url: repoURL)
        show(webViewController, sender: nil)
    }
    
    func fetchRepos(forUsername username: String,
                    completionHandler: @escaping (FetchReposResult) -> Void) {
        
        let urlString = "https://api.github.com/users/\(username)/repos"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // First unwrap the optional data
            guard let jsonData = data else {
                // If it is nil, there was probably a network error
                completionHandler(.failure(ResponseError.requestUnsucessful))
                return
            }
            
            do {
                // Deserialisation can throw an error, so we have to `try` and catch errors
                let deserialised = try JSONSerialization.jsonObject(with: jsonData, options: [])
                
                // As `deserialised` has type `Any` we need to cast
                guard let jsonRepos = deserialised as? [[String: Any]] else {
                    completionHandler(.failure(ResponseError.unexpectedResponseStructure))
                    return
                }
                var reposToProvide = [Repo]()
                for jsonRepo in jsonRepos {
                    guard let name = jsonRepo["name"] as? String,
                        let urlString = jsonRepo["html_url"] as? String,
                        let url = URL(string: urlString) else {
                            continue
                    }
                    let repo = Repo(name: name, url: url)
                    reposToProvide.append(repo)
                }
                
                completionHandler(.success(reposToProvide))
                
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}

extension ReposTableViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // If no username, clear the data
        guard let enteredUsername = textField.text else {
            repos = []
            tableView.reloadData()
            return true
        }
        
        // Fetch repositories from username entered into text field
        fetchRepos(forUsername: enteredUsername) { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let repos):
                    self?.repos = repos
                    
                case .failure(let error):
                    self?.repos = []
                    print("There was an error: \(error)")
                }
                self?.tableView.reloadData()
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
}
