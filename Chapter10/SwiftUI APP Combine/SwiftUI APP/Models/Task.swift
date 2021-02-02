//
//  Task.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation

class Task: Identifiable {
    
    var id = UUID()
    
    let response: TaskResponse
    
    init(taskResponse: TaskResponse) {
        self.response = taskResponse
    }
    
    var category: String {
        return response.category ?? ""
    }
    
    var description: String {
        return response.description ?? ""
    }
    
}

struct TaskResponse: Codable {
    let category: String?
    let description: String?
}
