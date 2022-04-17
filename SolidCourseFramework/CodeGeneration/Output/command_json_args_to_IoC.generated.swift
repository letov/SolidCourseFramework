// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import simd

protocol CommandJSONArgs: Decodable & Encodable {}

class CheckCollisionParamModel: CommandJSONArgs {
    var objectId: Int?
}

class MoveCollisionCommandParamModel: CommandJSONArgs {
    var objectId: Int?
}

class SetStartVelocityAndMoveCommandParamModel: CommandJSONArgs {
    var startVelocity: simd_int2?
}

class SetStartVelocityCommandParamModel: CommandJSONArgs {
    var startVelocity: simd_int2?
}

class CommandJSONArgsRegister {
    static func register() {
        do {
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            let decoder = JSONDecoder()
            queue.queue(try (IoC.register("Command.JSONArgs.BurnFuel") {
                try IoC.resolve("Command.BurnFuel", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.ChangeVelocity") {
                try IoC.resolve("Command.ChangeVelocity", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.CheckCollision") {
                let json = $0[1] as! String
                let args = try decoder.decode(CheckCollisionParamModel.self, from: json.data(using: .utf8)!)
                return try IoC.resolve("Command.CheckCollision", $0[0],
                        args.objectId!
                ) as Command
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.CheckFuel") {
                try IoC.resolve("Command.CheckFuel", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.MoveCollision") {
                let json = $0[1] as! String
                let args = try decoder.decode(MoveCollisionCommandParamModel.self, from: json.data(using: .utf8)!)
                return try IoC.resolve("Command.MoveCollision", $0[0],
                        args.objectId!
                ) as Command
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.Move") {
                try IoC.resolve("Command.Move", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.MoveFuel") {
                try IoC.resolve("Command.MoveFuel", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.RotateChangeVelocity") {
                try IoC.resolve("Command.RotateChangeVelocity", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.Rotate") {
                try IoC.resolve("Command.Rotate", $0[0])
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.SetStartVelocityAndMove") {
                let json = $0[1] as! String
                let args = try decoder.decode(SetStartVelocityAndMoveCommandParamModel.self, from: json.data(using: .utf8)!)
                return try IoC.resolve("Command.SetStartVelocityAndMove", $0[0],
                        args.startVelocity!
                ) as Command
            } as Command))
            queue.queue(try (IoC.register("Command.JSONArgs.SetStartVelocity") {
                let json = $0[1] as! String
                let args = try decoder.decode(SetStartVelocityCommandParamModel.self, from: json.data(using: .utf8)!)
                return try IoC.resolve("Command.SetStartVelocity", $0[0],
                        args.startVelocity!
                ) as Command
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
        } catch {
            fatalError()
        }
    }
}
