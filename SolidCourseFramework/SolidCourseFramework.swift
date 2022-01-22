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

class GlobalRegister {
    static func register() {
        do {
            let queue = Queue<Command>()
            try (IoC.register("Queue.Command") { _ in
                queue
            } as Command).execute()
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
        } catch {
            fatalError()
        }
    }
}
