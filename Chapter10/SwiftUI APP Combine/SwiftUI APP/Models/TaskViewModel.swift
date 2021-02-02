//
//  TaskViewModel.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 31/12/2020.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    init() {
        getTasks()
    }
    
    @Published var tasks = [Task]()
    
    private func getTasks() {
        
        guard let url = URL(string: "http://0.0.0.0:8080/tasks") else {
            return
        }
        
        NetworkManager.loadData(url: url) { tasksResponse in
            
            if let tasksResponse = tasksResponse {
                self.tasks = tasksResponse.map(Task.init)
            }
            
        }
        
    }
    
}
