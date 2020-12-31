//
//  File.swift
//  
//
//  Created by Chris Barker on 21/12/2020.
//

import Foundation
import Vapor
import TaskModule

var tasksByID = [String: Task]()

final class TaskControllerAPI {
                    
    func index(req: Request) throws -> EventLoopFuture<[Task]> {
        return Task.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Task> {
        let task = try req.content.decode(Task.self)
        
        // Example
        // let viewTask = TaskViewModel(title: "", category: "")
        
        return task.save(on: req.db).map { task }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Task.find(req.parameters.get("taskID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
}

extension TaskControllerAPI: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: index)
        tasks.post(use: create)
        tasks.group(":taskID") { task in
            tasks.delete(use: delete)
        }
    }

}
