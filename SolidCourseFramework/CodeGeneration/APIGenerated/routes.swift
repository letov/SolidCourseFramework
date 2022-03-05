import Vapor
import RoutingKit

// routes.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: 

extension String {
  var asPathComponents: [PathComponent] {
    return self.split(separator: "/").map {
      if $0.starts(with: "{") && $0.hasSuffix("}") {
        let start = $0.index($0.startIndex, offsetBy: 1)
        let end = $0.index($0.endIndex, offsetBy: -1)
        return PathComponent.parameter(String($0[start..<end]))
      } else {
        return PathComponent.constant(.init($0))
      }
    }
  }
}

public protocol AuthenticationMiddleware: Middleware {
  associatedtype AuthType: Authenticatable
  func authType() -> AuthType.Type
}

//Used when auth is not used
public class DummyAuthType: Authenticatable {}

public func routes<authForbearerAuth: AuthenticationMiddleware, game: GameApiDelegate, hello: HelloApiDelegate, user: UserApiDelegate>
  (_ app: RoutesBuilder, game: game, hello: hello, user: user, authForbearerAuth: authForbearerAuth)
  throws
  where authForbearerAuth.AuthType == game.AuthType, authForbearerAuth.AuthType == hello.AuthType, authForbearerAuth.AuthType == user.AuthType
  {
  let groupForbearerAuth = app.grouped([authForbearerAuth])
  //for game
  groupForbearerAuth.on(.PUT, "/game/command".asPathComponents) { (request: Request) -> EventLoopFuture<gameCommandPutResponse> in
    let body = try request.content.decode(InterpretCommandAPIModel.self)
    return try game.gameCommandPut(with: request, asAuthenticated: request.auth.require(authForbearerAuth.authType()), body: body)
  }
  groupForbearerAuth.on(.POST, "/game/new".asPathComponents) { (request: Request) -> EventLoopFuture<gameNewPostResponse> in
    let body = try request.content.decode([Int64].self)
    return try game.gameNewPost(with: request, asAuthenticated: request.auth.require(authForbearerAuth.authType()), body: body)
  }
  groupForbearerAuth.on(.GET, "/game/token/{id}".asPathComponents) { (request: Request) -> EventLoopFuture<gameTokenIdGetResponse> in
    guard let id = request.parameters.get("id", as: Int64.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter id")
    }
    return try game.gameTokenIdGet(with: request, asAuthenticated: request.auth.require(authForbearerAuth.authType()), id: id)
  }
  //for hello
  app.on(.GET, "/hello".asPathComponents) { (request: Request) -> EventLoopFuture<helloGetResponse> in
    return try hello.helloGet(with: request)
  }
  //for user
  groupForbearerAuth.on(.DELETE, "/user/delete/{id}".asPathComponents) { (request: Request) -> EventLoopFuture<userDeleteIdDeleteResponse> in
    guard let id = request.parameters.get("id", as: Int64.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter id")
    }
    return try user.userDeleteIdDelete(with: request, asAuthenticated: request.auth.require(authForbearerAuth.authType()), id: id)
  }
  groupForbearerAuth.on(.GET, "/user/get/{id}".asPathComponents) { (request: Request) -> EventLoopFuture<userGetIdGetResponse> in
    guard let id = request.parameters.get("id", as: Int64.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter id")
    }
    return try user.userGetIdGet(with: request, asAuthenticated: request.auth.require(authForbearerAuth.authType()), id: id)
  }
  app.on(.POST, "/user/login".asPathComponents) { (request: Request) -> EventLoopFuture<userLoginPostResponse> in
    let body = try request.content.decode(UserAPIModel.self)
    return try user.userLoginPost(with: request, body: body)
  }
  app.on(.GET, "/user/logout".asPathComponents) { (request: Request) -> EventLoopFuture<userLogoutGetResponse> in
    return try user.userLogoutGet(with: request)
  }
  app.on(.POST, "/user/register".asPathComponents) { (request: Request) -> EventLoopFuture<userRegisterPostResponse> in
    let body = try request.content.decode(UserAPIModel.self)
    return try user.userRegisterPost(with: request, body: body)
  }
}

