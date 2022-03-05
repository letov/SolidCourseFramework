//
//  Server.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation
import Vapor

class GameServerConfig {
    static let hsSecret = "secret"

    static public func routes(_ app: Application) throws {
        try SolidCourseFramework.routes(app, game: GameApi(), hello: HelloApi(), user: UserApi(), authForbearerAuth: SecurityMiddleware())
    }

    static public func signerHS(_ app: Application) throws {
        app.jwt.signers.use(.hs256(key: hsSecret))
    }
    
    static public func signerPublicRSA(_ app: Application, _ rsaPublicKey: String) throws {
        app.jwt.signers.use(.rs256(key: try .public(pem: rsaPublicKey)))
    }
    
    static public func signerPrivatePSA(_ app: Application, _ rsaPrivateKey: String) throws {
        app.jwt.signers.use(.rs256(key: try .private(pem: rsaPrivateKey)))
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

    public func configure(_ app: Application) throws {
        app.http.server.configuration.address = BindAddress.hostname(hostname, port: port)
        let corsConfiguration = CORSMiddleware.Configuration(
            allowedOrigin: .all,
            allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
            allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
        )
        let cors = CORSMiddleware(configuration: corsConfiguration)
        app.middleware.use(cors, at: .beginning)
        try GameServerConfig.routes(app)
        try GameServerConfig.signerHS(app)
    }

    func run() throws {
        try app.run()
    }
    
    func shutdown() {
        app.shutdown()
    }
}
 
