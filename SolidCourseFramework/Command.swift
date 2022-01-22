//
//  Command.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation
import simd

protocol Command {
    func execute() throws
}

protocol Movable {
    func getPosition() throws -> PropertyValue<simd_int2>
    func getVelocity() throws -> PropertyValue<simd_int2>
    func setPosition(position: PropertyValue<simd_int2>)
}

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
        m.setPosition(position: propertyValue)
    }
}

class MovableAdapter: Movable {
    let m: UObject
    init(m: UObject) {
        self.m = m
    }
    func getPosition() throws -> PropertyValue<simd_int2> {
        return try m.getProperty(propertyName: "Position") as! PropertyValue<simd_int2>
    }
    func getVelocity() throws -> PropertyValue<simd_int2>  {
        return try m.getProperty(propertyName: "Velocity") as! PropertyValue<simd_int2>
    }
    func setPosition(position: PropertyValue<simd_int2>) {
        m.setProperty(propertyName: "Position", propertyValue: position)
    }
}

protocol Rotable {
    func getDirection() throws -> PropertyValue<Int>
    func setDirection(direction: PropertyValue<Int>)
    func getAngularVelocity() throws -> PropertyValue<Int>
    func getMaxDirection() throws -> PropertyValue<Int>
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
        r.setDirection(direction: propertyValue)
    }
}

class RotateAdapter: Rotable {
    let r: UObject
    init(r: UObject) {
        self.r = r
    }
    func getDirection() throws -> PropertyValue<Int> {
        return try r.getProperty(propertyName: "Direction") as! PropertyValue<Int>
    }
    func getAngularVelocity() throws -> PropertyValue<Int> {
        return try r.getProperty(propertyName: "AngularVelocity") as! PropertyValue<Int>
    }
    func getMaxDirection() throws -> PropertyValue<Int> {
        return try r.getProperty(propertyName: "MaxDirection") as! PropertyValue<Int>
    }
    func setDirection(direction: PropertyValue<Int>) {
        r.setProperty(propertyName: "Direction", propertyValue: direction)
    }
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

protocol Fuelable {
    func getFuelReserve() throws -> PropertyValue<Int>
    func getFuelConsumptionRate() throws -> PropertyValue<Int>
    func setFuelReserve(fuelReserve: PropertyValue<Int>)
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
        f.setFuelReserve(fuelReserve: propertyValue)
    }
}

class FuelableAdapter: Fuelable {
    let f: UObject
    init(f: UObject) {
        self.f = f
    }
    func getFuelReserve() throws -> PropertyValue<Int> {
        return try f.getProperty(propertyName: "FuelReserve") as! PropertyValue<Int>
    }
    func getFuelConsumptionRate() throws -> PropertyValue<Int>  {
        return try f.getProperty(propertyName: "FuelConsumptionRate") as! PropertyValue<Int>
    }
    func setFuelReserve(fuelReserve: PropertyValue<Int>) {
        f.setProperty(propertyName: "FuelReserve", propertyValue: fuelReserve)
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

protocol MovableChangeVelocity: Movable {
    func setVelocity(velocity: PropertyValue<simd_int2>)
}

extension MovableAdapter: MovableChangeVelocity {
    func setVelocity(velocity: PropertyValue<simd_int2>) {
        m.setProperty(propertyName: "Velocity", propertyValue: velocity)
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
        m.setVelocity(velocity: propertyValue)
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

