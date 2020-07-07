//
//  TaskController.swift
//  App
//
//  Created by Keith Moon on 18/09/2017.
//

import Vapor
import HTTP
import JSON

extension Task: Parameterizable {
    
    static var uniqueSlug: String {
        return "task"
    }
    
    // returns the found model for the resolved url parameter
    static func make(for parameter: String) throws -> Task {
        
        guard let task = try Task.find(parameter) else {
            throw Abort.notFound
        }
        return task
    }
}

final class TaskController: ResourceRepresentable, EmptyInitializable {
    
    typealias Model = Task
    
    func index(request: Request) throws -> ResponseRepresentable {
        let tasks: [Task] = try Task.all()
        return try tasks.makeJSON()
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        
        guard let json = request.json else {
            throw Abort.badRequest
        }
        
        let task = try Task(json: json)
        try task.save()
        return try task.makeJSON()
    }
    
    func show(request: Request, task: Task) throws -> ResponseRepresentable {
        return try task.makeJSON()
    }
    
    func update(_ req: Request, task: Task) throws -> ResponseRepresentable {
        try task.update(for: req)
        try task.save()
        return try task.makeJSON()
    }
    
    func delete(request: Request, task: Task) throws -> ResponseRepresentable {
        try task.delete()
        let tasks: [Task] = try Task.all()
        return try tasks.makeJSON()
    }

    func makeResource() -> Resource<Task> {
        return Resource(index: index,
                        store: create,
                        show: show,
                        update: update,
                        destroy: delete)
    }
}
