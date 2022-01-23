//
//  Abstract.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 23.01.2022.
//

import Foundation
import simd

protocol Movable {
    func getPosition() throws -> PropertyValue<simd_int2>
    func getVelocity() throws -> PropertyValue<simd_int2>
    func setPosition(position: PropertyValue<simd_int2>) throws
}

protocol Rotable {
    func getDirection() throws -> PropertyValue<Int>
    func setDirection(direction: PropertyValue<Int>) throws
    func getAngularVelocity() throws -> PropertyValue<Int>
    func getMaxDirection() throws -> PropertyValue<Int>
}

protocol Fuelable {
    func getFuelReserve() throws -> PropertyValue<Int>
    func getFuelConsumptionRate() throws -> PropertyValue<Int>
    func setFuelReserve(fuelReserve: PropertyValue<Int>) throws
}

protocol MovableChangeVelocity: Movable {
    func setVelocity(velocity: PropertyValue<simd_int2>) throws
}
