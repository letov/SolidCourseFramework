//
//  Server.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation
import Vapor

class GameServerRoutes {
    static public func routes(_ app: Application) throws {
        try SolidCourseFramework.routes(app, game: GameApi(), hello: HelloApi(), user: UserApi(), authForbearerAuth: SecurityMiddleware())
    }
}

class GameServer {
    var app: Application
    var hostname: String
    var port: Int
    
    init(_ hostname: String = "127.0.0.1", _ port: Int = 8080) throws {
        self.hostname = hostname
        self.port = port
        let env = try Environment.detect()
        app = Application(env)
        try configure(app)
    }
    
    public func routes(_ app: Application) throws {
        try GameServerRoutes.routes(app)
    }
    
    public func configure(_ app: Application) throws {
        app.http.server.configuration.address = BindAddress.hostname(hostname, port: port)
        let corsConfiguration = CORSMiddleware.Configuration(
            allowedOrigin: .all,
            allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
            allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
        )
        let cors = CORSMiddleware(configuration: corsConfiguration)
        app.middleware.use(cors, at: .beginning)
        try routes(app)
        app.jwt.signers.use(.hs256(key: "secret"))
    }

    func run() throws {
        try app.run()
    }
    
    func shutdown() {
        app.shutdown()
    }
}
 
