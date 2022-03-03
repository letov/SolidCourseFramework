//
//  APIController.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation
import Vapor
import JWT

class SecurityMiddleware: AuthenticationMiddleware {
    typealias AuthType = JWTToken
    
    func authType() -> AuthType.Type {
        return JWTToken.self
    }
    
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        do {
            let token = try request.jwt.verify(as: authType())
            request.auth.login(JWTToken(userId: token.userId))
        } catch {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        return next.respond(to: request)
    }
}

struct JWTToken: Authenticatable, JWTPayload {
    var expirationTime: TimeInterval = 60 * 15 * 100
    var expiration: ExpirationClaim
    var userId: Int64
    init(userId: Int64) {
        self.userId = userId
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(expirationTime))
    }
    func verify(using signer: JWTSigner) throws {
        try expiration.verifyNotExpired()
    }
}

class UserApi: UserApiDelegate {
    typealias AuthType = JWTToken

    func userDeleteIdDelete(with req: Request, asAuthenticated user: AuthType, id: Int64) throws -> EventLoopFuture<userDeleteIdDeleteResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        try userManager.delete(id: Int(id))
        return req.eventLoop.makeSucceededFuture(userDeleteIdDeleteResponse.http400)
    }
    
    func userGetIdGet(with req: Request, asAuthenticated user: AuthType, id: Int64) throws -> EventLoopFuture<userGetIdGetResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        if let user = try userManager.get(id: Int(id)) {
            return req.eventLoop.makeSucceededFuture(userGetIdGetResponse.http200(user))
        } else {
            return req.eventLoop.makeSucceededFuture(userGetIdGetResponse.http400)
        }
    }
    
    func userRegisterPost(with req: Request, body: UserAPI) throws -> EventLoopFuture<userRegisterPostResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        if let user = try userManager.register(username: body.username!, password: body.password!) {
            return req.eventLoop.makeSucceededFuture(userRegisterPostResponse.http200(user))
        } else {
            return req.eventLoop.makeSucceededFuture(userRegisterPostResponse.http400)
        }
    }
    
    func userLoginPost(with req: Request, body: UserAPI) throws -> EventLoopFuture<userLoginPostResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        guard let username = body.username, let password = body.password else {
            return req.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        guard let user = try userManager.get(username: username) else {
            return req.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        guard user.password == password else {
            return req.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        let payload = JWTToken(userId: user.id!)
        let token = try req.jwt.sign(payload)
        return req.eventLoop.makeSucceededFuture(userLoginPostResponse.http200(JwtTokenAPI(token: token)))
    }
    
    func userLogoutGet(with req: Request) throws -> EventLoopFuture<userLogoutGetResponse> {
        return req.eventLoop.makeSucceededFuture(userLogoutGetResponse.http400)
    }
}

class GameApi: GameApiDelegate {
    typealias AuthType = JWTToken
    
    func gameCapabilitiesGet(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<gameCapabilitiesGetResponse> {
        let adapterList: AdapterList = try IoC.resolve("Adapter.List")
        let capabilitiesAPI = adapterList
            .getAll()
            .enumerated()
            .reduce(into: CapabilitiesAPI()) {
                $0.append(CapabilityAPI(id: Int64($1.offset), name: $1.element))
            }
        return req.eventLoop.makeSucceededFuture(gameCapabilitiesGetResponse.http200(capabilitiesAPI))
    }
    
    func gameNewGet(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<gameNewGetResponse> {
        return req.eventLoop.makeSucceededFuture(gameNewGetResponse.http400)
    }
    
    func gameCommandPut(with req: Request, asAuthenticated user: AuthType, body: GameCommandAPI) throws -> EventLoopFuture<gameCommandPutResponse> {
        //let decoded = try JSONDecoder().decode([String: Any].self, from: body.args!.data(using: .utf8)!)
        //body.args
        return req.eventLoop.makeSucceededFuture(gameCommandPutResponse.http400)
    }
}

class HelloApi: HelloApiDelegate {
    typealias AuthType = JWTToken
    
    func helloGet(with req: Request) throws -> EventLoopFuture<helloGetResponse> {
        return req.eventLoop.makeSucceededFuture(helloGetResponse.http200)
    }
}
