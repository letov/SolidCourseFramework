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
            let helper = Helper()
            let errorHandleList = ErrorHandleList()
            try (IoC.register("Queue.Command") { _ in
                queue
            } as Command).execute()
            queue.queue(try (IoC.register("Helper") { _ in
                helper
            } as Command))
            queue.queue(try (IoC.register("Error.Handle.List") { _ in
                errorHandleList
            } as Command))
            queue.queue(try (IoC.register("Error.Log") {
                ErrorCommand(command: $0[0] as! Command, error: $0[1] as! Error) {
                    NSLog(String(describing: $0) + " " + $1.localizedDescription)
                }
            } as Command))
            queue.queue(try (IoC.register("Error.Default") {
                try (IoC.resolve("Error.Log", $0[0], $0[1]) as Command)
            } as Command))
            queue.queue(try (IoC.register("Error.Handle") {
                let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
                return try (IoC.resolve(errorHandleList.getHandler(command: $0[0] as! Command), $0[0], $0[1]) as Command)
            } as Command))
            while !queue.isEmpty() {
                try queue.dequeue()!.execute()
            }
        } catch {
            fatalError()
        }
    }
}
