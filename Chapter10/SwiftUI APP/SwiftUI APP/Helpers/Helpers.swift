//
//  Helpers.swift
//  SwiftUI APP
//
//  Created by Chris Barker on 30/12/2020.
//

import Foundation

struct MockHelper {
    static func getTasks() -> [Task] {
        var quotes = [Task]()
        quotes.append(Task(description: "Get Eggs", category: "Shopping"))
        quotes.append(Task(description: "Get Milk", category: "Shopping"))
        quotes.append(Task(description: "Go for a run", category: "Health"))
        return quotes
    }
}
