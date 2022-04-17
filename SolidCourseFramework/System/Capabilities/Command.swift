//
//  Command.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation
import simd

class MoveCommand: Command  {
    let m: Movable
    init(m: Movable) {
        self.m = m
    }
    func execute() throws {
        let position = try m.getPosition()
        let velocity = try m.getVelocity()
        guard position.canChange else {
            throw ErrorList.commandException
        }
        let propertyValue = (value: position.value &+ velocity.value, canChange: position.canChange)
        try m.setPosition(position: propertyValue)
    }
}

class RotateCommand: Command {
    let r: Rotable
    init(r: Rotable) {
        self.r = r
    }
    func execute() throws {
        let direction = try r.getDirection()
        let angularVelocity = try r.getAngularVelocity()
        let MaxDirection = try r.getMaxDirection()
        guard direction.canChange else {
            throw ErrorList.commandException
        }
        let propertyValue = (value: (direction.value + angularVelocity.value) % MaxDirection.value, canChange: direction.canChange)
        try r.setDirection(direction: propertyValue)
    }
}

class CheckFuelCommand: Command  {
    let f: Fuelable
    init(f: Fuelable) {
        self.f = f
    }
    func execute() throws {
        let fuelReserve = try f.getFuelReserve()
        let fuelConsumptionRate = try f.getFuelConsumptionRate()
        if fuelConsumptionRate.value > fuelReserve.value {
            throw ErrorList.commandException
        }
    }
}

class BurnFuelCommand: Command  {
    let f: Fuelable
    init(f: Fuelable) {
        self.f = f
    }
    func execute() throws {
        let fuelReserve = try f.getFuelReserve()
        let fuelConsumptionRate = try f.getFuelConsumptionRate()
        guard fuelReserve.canChange else {
            throw ErrorList.commandException
        }
        let propertyValue = (value: fuelReserve.value - fuelConsumptionRate.value , canChange: fuelReserve.canChange)
        try f.setFuelReserve(fuelReserve: propertyValue)
    }
}

class MoveFuelCommand: MacroCommand {
    init(m: Movable, f: Fuelable) {
        super.init(commands: [
            CheckFuelCommand.init(f: f),
            MoveCommand.init(m: m),
            BurnFuelCommand.init(f: f),
        ])
    }
}

class ChangeVelocityCommand: Command {
    let m: MovableChangeVelocity
    let r: Rotable
    
    init(m: MovableChangeVelocity, r: Rotable) {
        self.m = m
        self.r = r
    }
    func execute() throws {
        let velocity = try m.getVelocity()
        let helpers = (try! IoC.resolve("Helper") as Helper)
        let lenght = helpers.vectorLenght(vector: velocity.value)
        let direction = try r.getDirection()
        let maxDirection = try r.getMaxDirection()
        guard velocity.canChange && lenght > 0 else {
            throw ErrorList.commandException
        }
        let angle = (360.0 * Float(direction.value)) / Float(maxDirection.value)
        let zeroVelocity = simd_int2(0, Int32(lenght))
        let newVelocity = helpers.rotateVector(vector: zeroVelocity, angle: angle)
        let propertyValue = (value: newVelocity, canChange: velocity.canChange)
        try m.setVelocity(velocity: propertyValue)
    }
}

class RotateChangeVelocityCommand: MacroCommand {
    init(m: MovableChangeVelocity, r: Rotable) {
        super.init(commands: [
            RotateCommand.init(r: r),
            ChangeVelocityCommand.init(m: m, r: r)
        ])
    }
}

class SetStartVelocityCommand: Command {
    let m: MovableChangeVelocity
    let startVelocity: simd_int2

    init(m: MovableChangeVelocity, startVelocity: simd_int2) {
        self.m = m
        self.startVelocity = startVelocity
    }
    func execute() throws {
        let velocity = try m.getVelocity()
        let propertyValue = (value: startVelocity, canChange: velocity.canChange)
        try m.setVelocity(velocity: propertyValue)
    }
}

class SetStartVelocityAndMoveCommand: MacroCommand { 
    init(m: MovableChangeVelocity, startVelocity: simd_int2) {
        super.init(commands: [
            SetStartVelocityCommand.init(m: m, startVelocity: startVelocity),
            MoveCommand.init(m: m)
        ])
    }
}

class CheckCollision: Command {
    let m: Movable
    let objectId: Int

    init(m: Movable, objectId: Int) {
        self.m = m
        self.objectId = objectId
    }
    func execute() throws {
        let area10 = (try! IoC.resolve("Area.10") as Area)
        let area5 = (try! IoC.resolve("Area.5") as Area)
        try area10.updateTable(m: m, objectId: objectId)
        try area5.updateTable(m: m, objectId: objectId)
        let objectIds10 = try area10.getNearObjectIds(m: m, objectId: objectId)
        let objectIds5 = try area10.getNearObjectIds(m: m, objectId: objectId)
        let objectIds = Array(Set(objectIds10 + objectIds5))
        // check collision objectId with objectIds
    }
}


class MoveCollisionCommand: MacroCommand {
    init(m: Movable, objectId: Int) {
        super.init(commands: [
            MoveCommand.init(m: m),
            CheckCollision.init(m: m, objectId: objectId),
        ])
    }
}
