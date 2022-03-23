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
import JWT

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
        try GameServerConfig.routes(sut)
        try GameServerConfig.signerHS(sut)
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
        if sut != nil {
            sut.shutdown()
        }
        sut = nil
        if FileManager.default.fileExists(atPath: dbFileRandFile) {
            try FileManager.default.removeItem(atPath: dbFileRandFile)
        }
        try super.tearDownWithError()
    }
    
    /*func testServerBySwagger() throws {
        let realGameServer = try GameServer()
        defer {
     realGameServer.shutdown()
        }
        try realGameServer.run()
        while true {
            
        }
    }*/
    
    func testRealServer() throws {
        Thread{
            let realGameServer = try! GameServer()
            defer {
                realGameServer.shutdown()
            }
            try! realGameServer.run()
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
        let origUser = UserAPIModel(id: 1, username: "test", password: "test")
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
                let signer = JWTSigner.hs256(key: GameServerConfig.hsSecret)
                let payload = try signer.verify(token.token!, as: JWTToken.self) as JWTToken
                XCTAssertEqual(payload.userId, 1)
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
    
    // openssl genrsa -out key.pem ; openssl rsa -in key.pem -outform PEM -pubout -out public.pem
    func getRSAKeys() -> (String, String, String) {
        let privateKeyFile = Bundle(for: type(of: self)).path(forResource: "key", ofType: "pem")
        let publicKeyFile = Bundle(for: type(of: self)).path(forResource: "public", ofType: "pem")
        let rsaPrivateKey = try! String(contentsOfFile: privateKeyFile!)
        let rsaPublicKey = try! String(contentsOfFile: publicKeyFile!)
        let fakeRsaPublicKey = """
        -----BEGIN PUBLIC KEY-----
        MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0cOtPjzABybjzm3fCg1aCYwnx
        PmjXpbCkecAWLj/CcDWEcuTZkYDiSG0zgglbbbhcV0vJQDWSv60tnlA3cjSYutAv
        7FPo5Cq8FkvrdDzeacwRSxYuIq1LtYnd6I30qNaNthntjvbqyMmBulJ1mzLI+Xg/
        aX4rbSL49Z3dAQn8vQIDAQAB
        -----END PUBLIC KEY-----
        """
        return (rsaPrivateKey, rsaPublicKey, fakeRsaPublicKey)
    }
    
    func testRSA() throws {
        let (rsaPrivateKey, rsaPublicKey, _) = getRSAKeys()
        let privateSigner = try JWTSigner.rs256(key: .private(pem: rsaPrivateKey))
        let publicSigner = try JWTSigner.rs256(key: .public(pem: rsaPublicKey))
        let payload = JWTToken(userId: 1)
        let privateSigned = try privateSigner.sign(payload)
        let userId1 = (try privateSigner.verify(privateSigned, as: JWTToken.self) as JWTToken).userId
        let userId2 = (try publicSigner.verify(privateSigned, as: JWTToken.self) as JWTToken).userId
        XCTAssertEqual(userId1, 1)
        XCTAssertEqual(userId2, 1)
    }

    func testAuthMicroservice() throws {
        let (rsaPrivateKey, rsaPublicKey, fakeRsaPublicKey) = getRSAKeys()
        sut.shutdown()
        sut = nil
        sut = Application(.testing)
        try GameServerConfig.routes(sut)
        try GameServerConfig.signerPrivatePSA(sut, rsaPrivateKey)
        let (_, tokenFromAuthMicroservice) = getUserAndToken()
        sut.shutdown()
        sut = nil
        sut = Application(.testing)
        try GameServerConfig.routes(sut)
        try GameServerConfig.signerPublicRSA(sut, rsaPublicKey)
        try sut.test(.GET, "/user/get/1", beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: tokenFromAuthMicroservice)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        sut.shutdown()
        sut = nil
        sut = Application(.testing)
        try GameServerConfig.routes(sut)
        try GameServerConfig.signerPublicRSA(sut, fakeRsaPublicKey)
        try sut.test(.GET, "/user/get/1", beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: tokenFromAuthMicroservice)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .unauthorized)
        })
    }
    
    func testNewGame() throws {
        let db: DBConnection = try IoC.resolve("DB")
        _ = try db.write("INSERT INTO users  (username, password) VALUES (??,??), (??,??), (??,??)", "t", "t", "t", "t", "t", "t")
        let (_, token) = getUserAndToken()
        try sut.test(.POST, "/game/new", beforeRequest: { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
            let userIds = [1,2]
            try req.content.encode(userIds)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let gameId = try res.content.decode(GameAPIModel.self).id!
            XCTAssertEqual(gameId, 0)
            try sut.test(.GET, "/game/token/\(gameId)", beforeRequest: { req in
                req.headers.bearerAuthorization = BearerAuthorization(token: token)
            }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                let gameToken = try res.content.decode(JwtTokenAPIModel.self).token
                let signer = JWTSigner.hs256(key: GameServerConfig.hsSecret)
                let payload = try signer.verify(gameToken!, as: JWTToken.self) as JWTToken
                XCTAssertEqual(payload.gameId, 0)
            })
        })
    }
}
