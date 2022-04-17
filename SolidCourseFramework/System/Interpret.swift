//
//  InterpretCommand.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 17.04.2022.
//

import Foundation

class InterpretCommand: Command {
    let objectId: Int
    let commandName: String
    let args: String
    
    init(objectId: Int, commandId: Int, args: String) throws {
        self.objectId = objectId
        let commandList: CommandList = try IoC.resolve("Command.List")
        guard let command = commandList[commandId] else {
            throw ErrorList.commandException
        }
        self.commandName = String(String(describing: command).dropLast("Command".count))
        self.args = args
    }
    
    init(objectId: Int, commandName: String, args: String, userId: Int) throws {
        let userObjectList: UserObjectList = try IoC.resolve("User.Object.List")
        print(userObjectList[objectId])
        guard nil != userObjectList[objectId] && 0 != userObjectList[objectId]?.count else {
            throw ErrorList.commandException
        }
        self.objectId = objectId
        self.commandName = commandName
        self.args = args
    }
    
    func execute() throws {
        let objectList: ObjectList = try IoC.resolve("Object.List")
        guard let object = objectList[objectId] else {
            throw ErrorList.commandException
        }
        try (try IoC.resolve("Command.JSONArgs.\(commandName)", object, args) as Command).execute()
    }
}
