//
//  ReposTableViewController.swift
//  CocoaTouch
//
//  Created by Chris Barker on 04/12/2020.
//

import UIKit
import SafariServices

struct Repo: Codable {
    let name: String?
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "html_url"
    }
    
}

enum FetchReposResult {
    case success([Repo])
    case failure(Error)
}

enum ResponseError: Error {
    case requestUnsuccessful
    case unexpectedResponseStructure
}

class ReposTableViewController: UITableViewController {

    // MARK: Private Variables
    
    internal var session = URLSession.shared
    
    internal var repos = [Repo]()
    
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.accessibilityIdentifier = "input.textfield.username"
        }
    }
    
    
    // MARK: Lifecyle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the Navigation Controller Title
        self.title = "Repos"
        
        // Set accessability identifiers
        self.tableView.accessibilityIdentifier = "view.tableview.repos"
        
        // Mock Data:
        /*
        let repo1 = Repo(name: "Test repo 1",
                         url: URL(string: "http://example.com/repo1")!)
        let repo2 = Repo(name: "Test repo 2",
                         url: URL(string: "http://example.com/repo2")!)
        repos.append(contentsOf: [repo1, repo2])
       */
                
    }

    // MARK: Private functions
    
    @discardableResult
    internal func fetchRepos(forUsername username: String, completionHandler: @escaping (FetchReposResult) -> Void) -> URLSessionDataTask? {
        
        let urlString = "https://api.github.com/users/\(username)/repos"
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // First unwrap the optional data
            guard let data = data else {
                completionHandler(.failure(ResponseError.requestUnsuccessful))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode([Repo].self, from: data)
                
                completionHandler(.success(responseObject))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
        
        return task
    }
    
    func isUserInputValid(withText text: String) -> Bool {
        return !text.contains(" ")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)

        let repo = repos[indexPath.row]
        cell.textLabel?.text = repo.name
        cell.accessibilityIdentifier = "view.tableview.cell.\(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repo = repos[indexPath.row]
        guard let repoURL = repo.url else { return }
        
        let webViewController = SFSafariViewController(url: repoURL)
        show(webViewController, sender: nil)
        
    }
    
    func available() {
        if #available(iOS 11.0, *) {
            UIView().layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
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
        
        fetchRepos(forUsername: enteredUsername){ [weak self] result in
            
            switch result {
            case .success(let repos):
                self?.repos = repos
                
            case .failure(let error):
                self?.repos.removeAll()
                print("There was an error: \(error)")
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
