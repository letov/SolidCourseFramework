//
// GameAPIModel.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /Models.GameAPIModel

import Vapor


public final class GameAPIModel: Content {

    public var id: Int64?
    public var gameObjects: ObjectsAPIModel?

    public init(id: Int64?, gameObjects: ObjectsAPIModel?) { 
        self.id = id
        self.gameObjects = gameObjects
    }
}
