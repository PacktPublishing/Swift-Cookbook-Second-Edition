import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.webSocket("talk-back") { req, ws in
        
        ws.onText { ws, text in
            if text.lowercased() == "hello" {
                ws.send("Is it me your are looking for...?")
                ws.send([1, 2, 3])
            }
        }
        
        ws.onPong { (ws) in
            // Pong
        }
        
        ws.onPing { (ws) in
            // Ping
        }
        
    }
    
    try app.register(collection: TaskControllerAPI())
}
