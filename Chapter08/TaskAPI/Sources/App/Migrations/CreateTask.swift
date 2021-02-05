//
//  File.swift
//  
//
//  Created by Chris Barker on 22/12/2020.
//

import Fluent

struct CreateTask: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("task")
            .id()
            .field("description", .string, .required)
            .field("category", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("task").delete()
    }
}
