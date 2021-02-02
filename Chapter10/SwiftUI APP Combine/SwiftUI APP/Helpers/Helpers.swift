//
//  Helpers.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation

struct MockHelper {
    static func getTasks() -> TaskViewModel {
        
        var task = [Task]()
        task.append(Task(taskResponse: TaskResponse(category: "Get Eggs", description: "Shopping")))
        task.append(Task(taskResponse: TaskResponse(category: "Get Milk", description: "Shopping")))
        task.append(Task(taskResponse: TaskResponse(category: "Go for a run", description: "Health")))
        
        let taskViewModel = TaskViewModel()
        taskViewModel.tasks = task
        
        return taskViewModel
    }
}

struct Helper {
    static func getCategoryIcon(category: String) -> String {
        
        switch category.lowercased() {
        case "shopping":
            return "bag"
        case "health":
            return "heart"
        default:
            return "info.circle"
        }
        
    }
}
