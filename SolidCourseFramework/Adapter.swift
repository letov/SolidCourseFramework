// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import simd

class FuelableAdapter: Adapter & Fuelable {
    var o: UObject
    required init(o: UObject) {
        self.o = o
    }
    typealias FType = () -> ()
    func getFuelReserve() throws -> PropertyValue<Int> {
        return try IoC.resolve("Fuelable:FuelReserve.get", o) as PropertyValue<Int>
    }
    func getFuelConsumptionRate() throws -> PropertyValue<Int> {
        return try IoC.resolve("Fuelable:FuelConsumptionRate.get", o) as PropertyValue<Int>
    }
    func setFuelReserve(fuelReserve: PropertyValue<Int>) throws {
        return try IoC.resolve("Fuelable:FuelReserve.set", o, fuelReserve)
    }
    func setAdditionMethods(_ args: [FType]) {
    }
}

class MovableAdapter: Adapter & Movable {
    var o: UObject
    required init(o: UObject) {
        self.o = o
    }
    typealias FType = () -> ()
    func getPosition() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("Movable:Position.get", o) as PropertyValue<simd_int2>
    }
    func getVelocity() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("Movable:Velocity.get", o) as PropertyValue<simd_int2>
    }
    func setPosition(position: PropertyValue<simd_int2>) throws {
        return try IoC.resolve("Movable:Position.set", o, position)
    }
    func setAdditionMethods(_ args: [FType]) {
    }
}

class MovableChangeVelocityAdapter: Adapter & MovableChangeVelocity {
    var o: UObject
    required init(o: UObject) {
        self.o = o
    }
    typealias FType = () -> ()
    func setVelocity(velocity: PropertyValue<simd_int2>) throws {
        return try IoC.resolve("MovableChangeVelocity:Velocity.set", o, velocity)
    }
    func getPosition() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("MovableChangeVelocity:Position.get", o) as PropertyValue<simd_int2>
    }
    func getVelocity() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("MovableChangeVelocity:Velocity.get", o) as PropertyValue<simd_int2>
    }
    func setPosition(position: PropertyValue<simd_int2>) throws {
        return try IoC.resolve("MovableChangeVelocity:Position.set", o, position)
    }
    func setAdditionMethods(_ args: [FType]) {
    }
}

class MovableStartFinishAdapter: Adapter & MovableStartFinish {
    var o: UObject
    required init(o: UObject) {
        self.o = o
    }
    typealias FType = () -> ()
    func getPosition() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("MovableStartFinish:Position.get", o) as PropertyValue<simd_int2>
    }
    func getVelocity() throws -> PropertyValue<simd_int2> {
        return try IoC.resolve("MovableStartFinish:Velocity.get", o) as PropertyValue<simd_int2>
    }
    func setPosition(position: PropertyValue<simd_int2>) throws {
        return try IoC.resolve("MovableStartFinish:Position.set", o, position)
    }
    var startF: () -> () = {}
    func start() {
        startF()
    }
    var finishF: () -> () = {}
    func finish() {
        finishF()
    }
    func setAdditionMethods(_ args: [FType]) {
        startF = args[0]
        finishF = args[1]
    }
}

class RotableAdapter: Adapter & Rotable {
    var o: UObject
    required init(o: UObject) {
        self.o = o
    }
    typealias FType = () -> ()
    func getDirection() throws -> PropertyValue<Int> {
        return try IoC.resolve("Rotable:Direction.get", o) as PropertyValue<Int>
    }
    func setDirection(direction: PropertyValue<Int>) throws {
        return try IoC.resolve("Rotable:Direction.set", o, direction)
    }
    func getAngularVelocity() throws -> PropertyValue<Int> {
        return try IoC.resolve("Rotable:AngularVelocity.get", o) as PropertyValue<Int>
    }
    func getMaxDirection() throws -> PropertyValue<Int> {
        return try IoC.resolve("Rotable:MaxDirection.get", o) as PropertyValue<Int>
    }
    func setAdditionMethods(_ args: [FType]) {
    }
}

class AdapterRegister {
    static func register() {
        do {
            let queue: Queue<Command> = try IoC.resolve("Queue.Command")
            let adapterList: AdapterList = try IoC.resolve("Adapter.List")
            adapterList[Fuelable.self] = FuelableAdapter.self
            queue.queue(try (IoC.register("Fuelable:FuelReserve.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "FuelReserve")
            } as Command))
            queue.queue(try (IoC.register("Fuelable:FuelConsumptionRate.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "FuelConsumptionRate")
            } as Command))
            queue.queue(try (IoC.register("Fuelable:FuelReserve.set") {
                ($0[0] as! UObject).setProperty(propertyName: "FuelReserve", propertyValue: $0[1] as! PropertyValue<Int>)
            } as Command))
            adapterList[Movable.self] = MovableAdapter.self
            queue.queue(try (IoC.register("Movable:Position.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Position")
            } as Command))
            queue.queue(try (IoC.register("Movable:Velocity.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Velocity")
            } as Command))
            queue.queue(try (IoC.register("Movable:Position.set") {
                ($0[0] as! UObject).setProperty(propertyName: "Position", propertyValue: $0[1] as! PropertyValue<simd_int2>)
            } as Command))
            adapterList[MovableChangeVelocity.self] = MovableChangeVelocityAdapter.self
            queue.queue(try (IoC.register("MovableChangeVelocity:Velocity.set") {
                ($0[0] as! UObject).setProperty(propertyName: "Velocity", propertyValue: $0[1] as! PropertyValue<simd_int2>)
            } as Command))
            queue.queue(try (IoC.register("MovableChangeVelocity:Position.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Position")
            } as Command))
            queue.queue(try (IoC.register("MovableChangeVelocity:Velocity.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Velocity")
            } as Command))
            queue.queue(try (IoC.register("MovableChangeVelocity:Position.set") {
                ($0[0] as! UObject).setProperty(propertyName: "Position", propertyValue: $0[1] as! PropertyValue<simd_int2>)
            } as Command))
            adapterList[MovableStartFinish.self] = MovableStartFinishAdapter.self
            queue.queue(try (IoC.register("MovableStartFinish:Position.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Position")
            } as Command))
            queue.queue(try (IoC.register("MovableStartFinish:Velocity.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Velocity")
            } as Command))
            queue.queue(try (IoC.register("MovableStartFinish:Position.set") {
                ($0[0] as! UObject).setProperty(propertyName: "Position", propertyValue: $0[1] as! PropertyValue<simd_int2>)
            } as Command))
            adapterList[Rotable.self] = RotableAdapter.self
            queue.queue(try (IoC.register("Rotable:Direction.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "Direction")
            } as Command))
            queue.queue(try (IoC.register("Rotable:Direction.set") {
                ($0[0] as! UObject).setProperty(propertyName: "Direction", propertyValue: $0[1] as! PropertyValue<Int>)
            } as Command))
            queue.queue(try (IoC.register("Rotable:AngularVelocity.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "AngularVelocity")
            } as Command))
            queue.queue(try (IoC.register("Rotable:MaxDirection.get") {
                try ($0[0] as! UObject).getProperty(propertyName: "MaxDirection")
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
        } catch {
            fatalError()
        }
    }
}
