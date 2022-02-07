//
//  ErrorHandler.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation

protocol ErrorCommandProtocol: Command {
    var command: Command { get set }
    var error: Error { get set }
    var f: (Command, Error) -> () { get set }
    init(command: Command, error: Error, f: @escaping (Command, Error) -> ())
    func execute()
}

class ErrorCommand: ErrorCommandProtocol {
    var command: Command
    var error: Error
    var f: (Command, Error) -> ()
    required init(command: Command, error: Error, f: @escaping (Command, Error) -> ()) {
        self.command = command
        self.error = error
        self.f = f
    }
    func execute() {
        f(command, error)
    }
}

class ErrorHandleList {
    var table = Dictionary<String, String>()
    func addHandler(command: Command, errorIoCKey: String) {
        let commandName = String(describing: command).components(separatedBy: ".")[1]
        table[commandName] = errorIoCKey
    }
    func getHandler(command: Command) -> String {
        let commandName = String(describing: command).components(separatedBy: ".")[1]
        return table[commandName] ?? "Error.Default"
    }
}
