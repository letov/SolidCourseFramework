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

enum ErrorList: Error {
    case commandException
    case ioCException
}

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
