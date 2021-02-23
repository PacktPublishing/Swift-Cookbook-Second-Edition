import Fluent
import FluentPostgresDriver
import Vapor
import NIOWebSocket
import WebSocketKit

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if let databaseURL = Environment.get("DATABASE_URL"),
       var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(configuration: postgresConfig),as: .psql)
        
    } else {
        
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? "vapor_database"
        ), as: .psql)
        
    }

    //app.migrations.add(CreateTodo())
    app.migrations.add(CreateTask())
    
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
    
//    app.webSocket("echo") { req, ws in
//        print(ws)
//        
//        ws.onText { ws, text in
//            print(text)
//            ws.send("got ya")
//        }
//        
//        ws.onBinary { ws, binary in
//            print(binary)
//        }
//        
//    }
    
}

