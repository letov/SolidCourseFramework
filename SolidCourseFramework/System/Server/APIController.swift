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
            request.auth.login(JWTToken(userId: token.userId, gameId: token.gameId))
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
    var gameId: Int64
    init(userId: Int64, gameId: Int64 = -1) {
        self.userId = userId
        self.gameId = gameId
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
    
    func userRegisterPost(with req: Request, body: UserAPIModel) throws -> EventLoopFuture<userRegisterPostResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        if let user = try userManager.register(username: body.username!, password: body.password!) {
            return req.eventLoop.makeSucceededFuture(userRegisterPostResponse.http200(user))
        } else {
            return req.eventLoop.makeSucceededFuture(userRegisterPostResponse.http400)
        }
    }
    
    func userLoginPost(with req: Request, body: UserAPIModel) throws -> EventLoopFuture<userLoginPostResponse> {
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
        return req.eventLoop.makeSucceededFuture(userLoginPostResponse.http200(JwtTokenAPIModel(token: token)))
    }
    
    func userLogoutGet(with req: Request) throws -> EventLoopFuture<userLogoutGetResponse> {
        return req.eventLoop.makeSucceededFuture(userLogoutGetResponse.http400)
    }
}

class GameApi: GameApiDelegate {
    typealias AuthType = JWTToken
    
    func gameNewPost(with req: Request, asAuthenticated user: AuthType, body: [Int64]) throws -> EventLoopFuture<gameNewPostResponse> {
        let userManager: UserManager = try IoC.resolve("UserManager")
        for userId in body {
            if try userManager.get(id: Int(userId)) == nil {
                return req.eventLoop.makeSucceededFuture(gameNewPostResponse.http400)
            }
        }
        var userIds = body
        userIds.append(user.userId)
        let game = Game(userIds: userIds.map { Int($0) } )
        let gameList: GameList = try IoC.resolve("Game.List")
        let gameId = gameList.add(game)
        return req.eventLoop.makeSucceededFuture(gameNewPostResponse.http200(GameAPIModel(id: Int64(gameId))))
    }
    
    func gameTokenIdGet(with req: Request, asAuthenticated user: AuthType, id: Int64) throws -> EventLoopFuture<gameTokenIdGetResponse> {
        let gameList: GameList = try IoC.resolve("Game.List")
        guard let game = gameList[Int(id)] else {
            return req.eventLoop.makeSucceededFuture(gameTokenIdGetResponse.http400)
        }
        guard game.hasUser(userId: Int(user.userId)) else {
            return req.eventLoop.makeSucceededFuture(gameTokenIdGetResponse.http400)
        }
        let payload = JWTToken(userId: user.userId, gameId: id)
        let token = try req.jwt.sign(payload)
        return req.eventLoop.makeSucceededFuture(gameTokenIdGetResponse.http200(JwtTokenAPIModel(token: token)))
    }
    
    func gameCommandPut(with req: Request, asAuthenticated user: AuthType, body: InterpretCommandAPIModel) throws -> EventLoopFuture<gameCommandPutResponse> {
        do {
            let command = InterpretCommand(objectId: Int(body.objectId!), commandId: Int(body.commandId!), args: body.args!)
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            queue.queue(command)
        } catch {
            return req.eventLoop.makeSucceededFuture(gameCommandPutResponse.http400)
        }
        return req.eventLoop.makeSucceededFuture(gameCommandPutResponse.http200)
    }
}

class HelloApi: HelloApiDelegate {
    typealias AuthType = JWTToken
    
    func helloGet(with req: Request) throws -> EventLoopFuture<helloGetResponse> {
        return req.eventLoop.makeSucceededFuture(helloGetResponse.http200)
    }
}

