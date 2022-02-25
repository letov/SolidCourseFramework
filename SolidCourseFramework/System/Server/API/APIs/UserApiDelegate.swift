import Vapor
// UserApiDelegate.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /APIs.User


public enum userRegisterPostResponse: ResponseEncodable {
  case http200(User)
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}

public protocol UserApiDelegate {
  associatedtype AuthType
  /**
  POST /user/register */
  func userRegisterPost(with req: Request, body: Body) throws -> EventLoopFuture<userRegisterPostResponse>
}
