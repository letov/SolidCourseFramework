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
    func getKey(_ command: Command) -> String {
        return String(describing: command).components(separatedBy: ".")[1]
    }
    subscript(_ command: Command) -> String {
        get {
            return table[getKey(command)] ?? "Error.Default"
        }
        set {
            table[getKey(command)] = newValue
        }
    }
}
