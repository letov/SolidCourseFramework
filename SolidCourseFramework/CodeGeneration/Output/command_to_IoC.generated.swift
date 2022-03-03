// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import simd

class CommandRegister {
    static func register() {
        do {
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            let commandList: CommandList = try IoC.resolve("Command.List")
            commandList.append(BurnFuelCommand.self)
            queue.queue(try (IoC.register("Command.BurnFuel") {
                BurnFuelCommand(
                    f: try IoC.resolve("Adapter", Fuelable.self, $0[0]) as Fuelable
                )
            } as Command))
            commandList.append(ChangeVelocityCommand.self)
            queue.queue(try (IoC.register("Command.ChangeVelocity") {
                ChangeVelocityCommand(
                    m: try IoC.resolve("Adapter", MovableChangeVelocity.self, $0[0]) as MovableChangeVelocity, 
                    r: try IoC.resolve("Adapter", Rotable.self, $0[1]) as Rotable
                )
            } as Command))
            commandList.append(CheckFuelCommand.self)
            queue.queue(try (IoC.register("Command.CheckFuel") {
                CheckFuelCommand(
                    f: try IoC.resolve("Adapter", Fuelable.self, $0[0]) as Fuelable
                )
            } as Command))
            commandList.append(MoveCommand.self)
            queue.queue(try (IoC.register("Command.Move") {
                MoveCommand(
                    m: try IoC.resolve("Adapter", Movable.self, $0[0]) as Movable
                )
            } as Command))
            commandList.append(MoveFuelCommand.self)
            queue.queue(try (IoC.register("Command.MoveFuel") {
                MoveFuelCommand(
                    m: try IoC.resolve("Adapter", Movable.self, $0[0]) as Movable, 
                    f: try IoC.resolve("Adapter", Fuelable.self, $0[1]) as Fuelable
                )
            } as Command))
            commandList.append(RotateChangeVelocityCommand.self)
            queue.queue(try (IoC.register("Command.RotateChangeVelocity") {
                RotateChangeVelocityCommand(
                    m: try IoC.resolve("Adapter", MovableChangeVelocity.self, $0[0]) as MovableChangeVelocity, 
                    r: try IoC.resolve("Adapter", Rotable.self, $0[1]) as Rotable
                )
            } as Command))
            commandList.append(RotateCommand.self)
            queue.queue(try (IoC.register("Command.Rotate") {
                RotateCommand(
                    r: try IoC.resolve("Adapter", Rotable.self, $0[0]) as Rotable
                )
            } as Command))
            commandList.append(SetStartVelocityAndMoveCommand.self)
            queue.queue(try (IoC.register("Command.SetStartVelocityAndMove") {
                SetStartVelocityAndMoveCommand(
                    m: try IoC.resolve("Adapter", MovableChangeVelocity.self, $0[0]) as MovableChangeVelocity, 
                    startVelocity: $0[1] as! simd_int2
                )
            } as Command))
            commandList.append(SetStartVelocityCommand.self)
            queue.queue(try (IoC.register("Command.SetStartVelocity") {
                SetStartVelocityCommand(
                    m: try IoC.resolve("Adapter", MovableChangeVelocity.self, $0[0]) as MovableChangeVelocity, 
                    startVelocity: $0[1] as! simd_int2
                )
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
        } catch {
            fatalError()
        }
    }
}
