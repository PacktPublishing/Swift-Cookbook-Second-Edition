//
//  NetworkManager.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 31/12/2020.
//

import Foundation

class NetworkManager {
    
    static func loadData(url: URL, completion: @escaping ([TaskResponse]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONDecoder().decode([TaskResponse].self, from: data) {
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }.resume()
        
    }
    
}
