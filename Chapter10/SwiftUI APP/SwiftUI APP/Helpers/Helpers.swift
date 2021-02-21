//
//  Helpers.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation

struct MockHelper {
    static func getTasks() -> [Task] {
        var tasks = [Task]()
        tasks.append(Task(description: "Get Eggs", category: "Shopping"))
        tasks.append(Task(description: "Get Milk", category: "Shopping"))
        tasks.append(Task(description: "Go for a run", category: "Health"))
        return tasks
    }
}
