//
//  InterpretCommand.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 02.03.2022.
//

import Foundation

class InterpretCommand: Command {
    let objectId: Int
    let commandId: Int
    let args: String
    
    init(objectId: Int, commandId: Int, args: String) {
        self.objectId = objectId
        self.commandId = commandId
        self.args = args
    }
    
    func execute() throws { 
        let objectList: ObjectList = try IoC.resolve("Object.List")
        guard let object = objectList[objectId] else {
            throw ErrorList.commandException
        }
        let commandList: CommandList = try IoC.resolve("Command.List")
        guard let command = commandList[commandId] else {
            throw ErrorList.commandException
        }
        let commandName = String(String(describing: command).dropLast("Command".count))
        try (try IoC.resolve("Command.JSONArgs.\(commandName)", object, args) as Command).execute()
    }
}
