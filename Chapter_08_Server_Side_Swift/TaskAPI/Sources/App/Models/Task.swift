//
//  Task.swift
//  App
//
//  Created by Keith Moon on 18/09/2017.
//

import Foundation
import JSON

final class Task: JSONConvertible {
    
    enum Error: Swift.Error {
        case expectedJSONData
    }
    
    var id: String
    var description: String
    var category: String
    
    init(id: String, description: String, category: String) {
        self.id = id
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
        
        if let id = json["id"]?.string {
            self.id = id
        } else {
            self.id = UUID().uuidString
        }
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("description", description)
        try json.set("category", category)
        return json
    }
}
