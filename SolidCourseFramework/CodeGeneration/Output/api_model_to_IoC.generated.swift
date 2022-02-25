// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import simd

class APIModelRegister {
    static func register() {
        do {
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            queue.queue(try (IoC.register("APIModel.Body") {
                Body(
                    username: $0[0] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.Capability") {
                Capability(
                    `id`: $0[0] as! Int64?, 
                    name: $0[1] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.Game") {
                Game(
                    `id`: $0[0] as! Int64?, 
                    gameObjects: $0[1] as! GameObjects?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.GameObject") {
                GameObject(
                    `id`: $0[0] as! Int64?, 
                    name: $0[1] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.User") {
                User(
                    `id`: $0[0] as! Int64?, 
                    username: $0[1] as! String?, 
                    password: $0[2] as! String?
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
