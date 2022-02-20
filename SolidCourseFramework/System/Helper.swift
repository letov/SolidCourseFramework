//
//  Helper.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation

import Foundation
import simd

class Helper {
    func makeRotationMatrix(angle: Float) -> simd_float3x3 {
        let angle = Measurement(value: -Double(angle), unit: UnitAngle.degrees)
        let radians = Float(angle.converted(to: .radians).value)
        let rows = [
            simd_float3(cos(radians), -sin(radians), 0),
            simd_float3(sin(radians),  cos(radians), 0),
            simd_float3(0,                        0, 1)
        ]
        return float3x3(rows: rows)
    }
    func rotateVector(vector: simd_int2, angle: Float) -> simd_int2 {
        let vector = simd_float3(Float(vector.x), Float(vector.y), 0)
        let rotationMatrix = makeRotationMatrix(angle: angle)
        let rotatedVector = rotationMatrix * vector
        return simd_int2(Int32(round(rotatedVector.x)), Int32(round(rotatedVector.y)))
    }
    func vectorLenght(vector: simd_int2) -> Int {
        let vector = simd_float2(Float(vector.x), Float(vector.y))
        let lenght = simd_length(vector)
        return Int(round(lenght))
    }
}
