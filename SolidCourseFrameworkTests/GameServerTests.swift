//
//  ServerTests.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation
import XCTVapor
@testable import SolidCourseFramework
import XCTest
import Cuckoo
import simd

final class GameServerTests: XCTestCase {
    
    var sut: Application!
    var dbFileRandFile = String()
    
    func generateRandomString(size: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<size).map { _ in base.randomElement()!})
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Application(.testing)
        sut.jwt.signers.use(.hs256(key: "secret"))
        try GameServerRoutes.routes(sut)
        // new db file for every test
        guard let dbFile = Bundle(for: type(of: self)).path(forResource: "db", ofType: "sqlite") else {
            throw ErrorList.dbError
        }
        dbFileRandFile = dbFile.replacingOccurrences(of: "db.sqlite", with: "db\(generateRandomString()).sqlite")
        if FileManager.default.fileExists(atPath: dbFileRandFile) {
            try FileManager.default.removeItem(atPath: dbFileRandFile)
        }
        try FileManager.default.copyItem(atPath: dbFile, toPath: dbFileRandFile)
        GlobalRegister.register(dbFile: dbFileRandFile)
        let db: DBConnection = try IoC.resolve("DB")
        _ = try db.write("DELETE FROM users WHERE 1")
    }

    override func tearDownWithError() throws {
        sut.shutdown()
        sut = nil
        if FileManager.default.fileExists(atPath: dbFileRandFile) {
            try FileManager.default.removeItem(atPath: dbFileRandFile)
        }
        try super.tearDownWithError()
    }
    
    /*func testServerBySwagger() throws {
        let gameServer = try GameServer()
        defer {
            gameServer.shutdown()
        }
        try gameServer.run()
        while true {
            
        }
    }*/
    
    func testRealServer() throws {
        Thread{
            let gameServer = try! GameServer()
            defer {
                gameServer.shutdown()
            }
            try! gameServer.run()
        }.start()
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/hello")!);
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 10)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                XCTAssertEqual(response.statusCode, 200)
                semaphore.signal()
            }
        }
        task.resume()
        XCTAssertNotEqual(semaphore.wait(timeout: .now() + 3), .timedOut)
    }
    
    func testHelloAPI() throws {
        try sut.test(.GET, "hello") { res in
            XCTAssertEqual(res.status, .ok)
        }
    }

    func testUserAPIModel() throws {
        let origUser = UserAPIModel(id: 0, username: "test", password: "test")
        try sut.test(.POST, "/user/register", beforeRequest: { req in
            try req.content.encode(origUser)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let resUser = try res.content.decode(UserAPIModel.self)
            try sut.test(.POST, "/user/login", beforeRequest: { req in
                try req.content.encode(resUser)
            }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                let token = try res.content.decode(JwtTokenAPIModel.self)
                XCTAssertNotEqual(token.token, "")
            })
        })
    }
    
    func getUserAndToken() -> (UserAPIModel, String) {
        let userManager: UserManager = try! IoC.resolve("UserManager")
        let user = try! userManager.register(username: "test", password: "test")
        let payload = JWTToken(userId: user!.id!)
        let token = try! sut.jwt.signers.sign(payload)
        return (user!, token)
    }
    
    func testAuthRequest() throws {
        let (user, token) = getUserAndToken()
        try sut.test(.GET, "/user/get/1", beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let resUser = try res.content.decode(UserAPIModel.self)
            XCTAssertEqual(user.username, resUser.username)
        })
    }
    
    func testGameCommandPut() throws {
        let obj = MockUObject()
        stub(obj) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
            when(mock.setProperty(propertyName: "Velocity", propertyValue: any())).thenDoNothing()
        }
        let objectList = try! (IoC.resolve("Object.List") as ObjectList)
        objectList.append(obj)
        let interpretCommandAPIModel = InterpretCommandAPIModel(objectId: 0, commandId: 7, args: "{\"startVelocity\":[0,0]}")
        let (_, token) = getUserAndToken()
        try sut.test(.PUT, "/game/command", beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
            try req.content.encode(interpretCommandAPIModel)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let queue: Queue<SolidCourseFramework.Command> = try IoC.resolve("Queue.Command") 
            XCTAssertEqual(queue.isEmpty(), false)
            verify(obj, never()).setProperty(propertyName: "Position", propertyValue: any())
            try queue.dequeue()?.execute()
            verify(obj).setProperty(propertyName: "Position", propertyValue: any())
        })
    }
}
