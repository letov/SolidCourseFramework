//
//  Server.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 19.02.2022.
//

import Foundation
import Vapor

class TankServer {
    static var app: Application?
    
    static func routes(_ app: inout Application) {
        app.get { req in
            return "It works!"
        }

        app.get("hello") { req -> String in
            return "Hello, world!"
        }
    }
    
    static func start() throws {
        let env = try Environment.detect()
        app = Application(env)
        routes(&app!)
        Thread {
            try! app!.run()
        }.start()
    }
    
    static func stop() {
        app?.shutdown()
    }
}

