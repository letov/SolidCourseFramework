//
//  SolidCourseFramework.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 22.12.2021.
//

import Foundation
import simd

typealias PropertyValue<T> = (value: T, canChange: Bool)

protocol UObject {
   func getProperty(propertyName: String) throws -> PropertyValue<Any>
   func setProperty(propertyName: String, propertyValue: PropertyValue<Any>)
}

protocol Adapter {
    var o: UObject { get set }
    init(o: UObject)
    typealias FType = () -> ()
    func setAdditionMethods(_ args: [FType])
}

enum ErrorList: Error {
    case commandException
    case ioCException
}

protocol Command {
    func execute() throws
}

class MacroCommand: Command {
    var commands = Array<Command>()
    init(commands: Array<Command>) {
        self.commands = commands
    }
    func execute() throws {
        try _ = commands.map { try $0.execute() }
    }
}

class AdapterList {
    var table = Dictionary<String, Adapter.Type>()
    func getKey(_ a: Any) -> String {
        return String(describing: a)
    }
    subscript(_ abstract: Any) -> Adapter.Type? {
        get {
            return table[getKey(abstract)]
        }
        set {
            table[getKey(abstract)] = newValue
        }
    }
}


class GlobalRegister {
    static func register() {
        do {
            let queue = Queue<Command>()
            let helper = Helper()
            let errorHandleList = ErrorHandleList()
            let adapterList = AdapterList()
            try (IoC.register("Queue.Command") { _ in
                queue
            } as Command).execute()
            queue.queue(try (IoC.register("Helper") { _ in
                helper
            } as Command))
            queue.queue(try (IoC.register("Error.Handle.List") { _ in
                errorHandleList
            } as Command))
            queue.queue(try (IoC.register("Error.Log") {
                ErrorCommand(command: $0[0] as! Command, error: $0[1] as! Error) {
                    NSLog(String(describing: $0) + " " + $1.localizedDescription)
                }
            } as Command))
            queue.queue(try (IoC.register("Error.Default") {
                try (IoC.resolve("Error.Log", $0[0], $0[1]) as Command)
            } as Command))
            queue.queue(try (IoC.register("Error.Handle") {
                let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
                return try (IoC.resolve(errorHandleList[$0[0] as! Command], $0[0], $0[1]) as Command)
            } as Command))
            queue.queue(try (IoC.register("Adapter.List") {_ in
                adapterList
            } as Command))
            queue.queue(try (IoC.register("Adapter") {
                let adapterList: AdapterList = try IoC.resolve("Adapter.List")
                return (adapterList[$0[0]]!).init(o: $0[1] as! UObject)
            } as Command))
            queue.queue(try (IoC.register("ThreadQueue") {_ in
                ThreadQueue()
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
            AdapterRegister.register()
            CommandRegister.register()
        } catch {
            fatalError()
        }
    }
}
