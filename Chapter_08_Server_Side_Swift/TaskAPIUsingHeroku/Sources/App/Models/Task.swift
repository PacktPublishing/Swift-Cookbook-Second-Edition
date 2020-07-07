//
//  Task.swift
//  App
//
//  Created by Keith Moon on 18/09/2017.
//

import Foundation
import JSON
import FluentProvider

final class Task: JSONConvertible, Model {
    
    // MARK: - Entity Conformance
    
    var storage = Storage()
    
    init(row: Row) throws {
        
        description = try row.get("description")
        category = try row.get("category")
    }
    
    func makeRow() throws -> Row {
        
        var row = Row()
        try row.set("id", id)
        try row.set("description", description)
        try row.set("category", category)
        return row
    }
    
    // MARK: -
    
    enum Error: Swift.Error {
        case expectedJSONData
    }
    
    var description: String
    var category: String
    
    init(description: String, category: String) {
        self.description = description
        self.category = category
    }
    
    required init(json: JSON) throws {
        
        guard
            let description = json["description"]?.string,
            let category = json["category"]?.string else {
                throw Error.expectedJSONData
        }
        self.description = description
        self.category = category
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("description", description)
        try json.set("category", category)
        return json
    }
}

extension Task: Preparation {
    
    static func prepare(_ database: Database) throws {
        
        try database.create(self) { builder in
            builder.id()
            builder.string("description")
            builder.string("category")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Task: Updateable {
    
    public static var updateableKeys: [UpdateableKey<Task>] {
        
        return [UpdateableKey("description", String.self) { (task, description) in
                    task.description = description
                },
                UpdateableKey("category", String.self) { (task, category) in
                    task.category = category
                }]
    }
}
