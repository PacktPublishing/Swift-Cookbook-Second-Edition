//
//  File.swift
//  
//
//  Created by Chris Barker on 21/12/2020.
//

import Foundation
import Vapor
import Fluent

final class Task: Content, Model {
    
    static let schema = "task"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "category")
    var category: String
    
    init() { }

    init(id: UUID? = nil, description: String, category: String) {
        self.id = id
        self.description = description
        self.category = category
    }
    
}
