// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import simd

class APIModelRegister {
    static func register() {
        do {
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            queue.queue(try (IoC.register("APIModel.CapabilityAPIModel") {
                CapabilityAPIModel(
                    id: $0[0] as! NSNumber as! Int64?, 
                    name: $0[1] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.GameAPIModel") {
                GameAPIModel(
                    id: $0[0] as! NSNumber as! Int64?, 
                    gameObjects: $0[1] as! ObjectsAPIModel?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.InterpretCommandAPIModel") {
                InterpretCommandAPIModel(
                    objectId: $0[0] as! NSNumber as! Int64?, 
                    commandId: $0[1] as! NSNumber as! Int64?, 
                    args: $0[2] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.JwtTokenAPIModel") {
                JwtTokenAPIModel(
                    token: $0[0] as! String?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.ObjectAPIModel") {
                ObjectAPIModel(
                    id: $0[0] as! NSNumber as! Int64?, 
                    name: $0[1] as! String?, 
                    capabilities: $0[2] as! CapabilitiesAPIModel?
                )
            } as Command))
            queue.queue(try (IoC.register("APIModel.UserAPIModel") {
                UserAPIModel(
                    id: $0[0] as! NSNumber as! Int64?, 
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
