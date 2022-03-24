//
//  ThreadQueue.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 21.02.2022.
//
import Foundation

class StartQueue: Command {
    func execute() throws {
    }
}

class HardStopQueue: Command {
    func execute() throws {
    }
}

class SoftStopQueue: Command {
    func execute() throws {
    }
}

class ThreadQueue {
    var queue = OperationQueue()
    init() {
        queue.maxConcurrentOperationCount = 0
    }
    func add(command: Command) {
        if command is HardStopQueue {
            queue.cancelAllOperations()
        }
        if command is SoftStopQueue {
            queue.waitUntilAllOperationsAreFinished()
        }
        if command is StartQueue {
            queue.maxConcurrentOperationCount = 1
        }
        queue.addOperation {
            do {
                try command.execute()
            } catch {
                try! (IoC.resolve("Error.Handle", command, error) as Command).execute()
            }
        }
    }
}
