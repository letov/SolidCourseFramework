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
    case dbError
    case serverError
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
    func getAll() -> [String] {
        return table.reduce(into: [String]()) {
            $0.append($1.key)
        }
    }
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

class ObjectList {
    var table = [UObject]()
    subscript(_ objectId: Int) -> UObject? {
        get {
            return table[objectId]
        }
    }
    func append(_ o: UObject) {
        table.append(o)
    }
}

class CommandList {
    var table = [Command.Type]()
    subscript(_ commandId: Int) -> Command.Type? {
        get {
            return table[commandId]
        }
    }
    func append(_ command: Command.Type) {
        table.append(command)
    }
}

class Game {
    var userIds: Set<Int>
    func hasUser(userId: Int) -> Bool {
        return userIds.contains(userId)
    }
    init(userIds: [Int]) {
        self.userIds = Set<Int>(userIds)
    }
}

class GameList {
    var table = [Int: Game]()
    subscript(_ gameId: Int) -> Game? {
        get {
            return table[gameId]
        }
    }
    var freeGameId: Int {
        var i = 0
        while table[i] != nil {
            i += 1
        }
        return i
    }
    func add(_ game: Game) -> Int {
        let id = freeGameId
        table[id] = game
        return id
    }
}

class GlobalRegister {
    static func register(dbFile: String) {
        do {
            let db = try DB(dbFile: dbFile)
            try (IoC.register("DB") { _ in
                db
            } as Command).execute()
            let queue = Queue<Command>()
            let helper = Helper()
            let errorHandleList = ErrorHandleList()
            let adapterList = AdapterList()
            let userManager = try UserManager()
            let objectList = ObjectList()
            let commandList = CommandList()
            let gameList = GameList()
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
            queue.queue(try (IoC.register("Adapter.List") { _ in
                adapterList
            } as Command))
            queue.queue(try (IoC.register("Command.List") { _ in
                commandList
            } as Command))
            queue.queue(try (IoC.register("Object.List") { _ in
                objectList
            } as Command))
            queue.queue(try (IoC.register("Game.List") { _ in
                gameList
            } as Command))
            queue.queue(try (IoC.register("Adapter") {
                let adapterList: AdapterList = try IoC.resolve("Adapter.List")
                return (adapterList[$0[0]]!).init(o: $0[1] as! UObject)
            } as Command))
            queue.queue(try (IoC.register("UserManager") { _ in
                userManager
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
            APIModelRegister.register()
            AdapterRegister.register()
            CommandRegister.register()
            CommandJSONArgsRegister.register()
        } catch {
            fatalError()
        }
    }
}
