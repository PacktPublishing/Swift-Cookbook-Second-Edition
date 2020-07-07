import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
        
        try resource("task", TaskController.self)
        
//        post("task") { request in
//            
//            guard let json = request.json else {
//                throw Abort.badRequest
//            }
//            
//            let task = try Task(json: json)
//            tasks.append(task)
//            return try task.makeJSON()
//        }
//
//        get("task") { request in
//            return try tasks.makeJSON()
//        }
    }
}
