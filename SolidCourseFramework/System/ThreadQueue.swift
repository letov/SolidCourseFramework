//
//  ThreadQueue.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 21.02.2022.
//
import Foundation

class PauseQueue: Command {
    func execute() throws { }
}

class StartQueue: Command {
    func execute() throws { }
}

class HardStopQueue: Command {
    func execute() throws { }
}

class SoftStopQueue: Command {
    func execute() throws { }
}

class MoveToQueue: Command {
    let toQueue: String
    init(toQueue: String) {
        self.toQueue = toQueue
    }
    func execute() throws { }
}

class RunQueue: Command {
    func execute() throws { }
}

class ThreadQueue {
    var queue = OperationQueue()
    init() {
        queue.maxConcurrentOperationCount = 0
    }
    func add(command: Command) {
        if try! IoC.resolve("ThreadQueue.isHardStopQueue", command) {
            queue.cancelAllOperations()
        }
        if try! IoC.resolve("ThreadQueue.isSoftStopQueue", command) {
            queue.waitUntilAllOperationsAreFinished()
        }
        if try! IoC.resolve("ThreadQueue.isStartQueue", command) {
            queue.maxConcurrentOperationCount = 1
        }
        if try! IoC.resolve("ThreadQueue.isPauseQueue", command) {
            queue.maxConcurrentOperationCount = 0
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

class ThreadQueueContext {
    var state: ThreadQueueState?
    var queue = OperationQueue()
    init() {
        self.state = try! (IoC.resolve("ThreadQueueState.Ready", self) as ThreadQueueState)
        queue.maxConcurrentOperationCount = 0
    }
    func add(command: Command) {
        self.state = self.state?.add(command: command)
    }
}

protocol ThreadQueueState {
    func add(command: Command) -> ThreadQueueState?
}

class ThreadQueuStateBase: ThreadQueueState {
    var context: ThreadQueueContext
    init(context: ThreadQueueContext) {
        self.context = context
    }
    func add(command: Command) -> ThreadQueueState? {
        return nil
    }
}

class ThreadQueueStateReady: ThreadQueuStateBase {
    override func add(command: Command) -> ThreadQueueState? {
        if try! IoC.resolve("ThreadQueue.isHardStopQueue", command) {
            context.queue.cancelAllOperations()
            return nil
        }
        if try! IoC.resolve("ThreadQueue.isMoveToQueue", command) {
            let newState = ThreadQueueMoveToState(context: context)
            newState.moveToQueue(toQueue: (command as! MoveToQueue).toQueue)
            return newState
        }
        context.queue.addOperation {
            do {
                try command.execute()
            } catch {
                try! (IoC.resolve("Error.Handle", command, error) as Command).execute()
            }
        }
        return self
    }
}

class ThreadQueueMoveToState: ThreadQueuStateBase {
    var toQueue: String?
    func moveToQueue(toQueue: String) {
        let queue: ThreadQueueContext = try! IoC.resolve(toQueue)
        queue.queue = context.queue
    }
    override func add(command: Command) -> ThreadQueueState? {
        if try! IoC.resolve("ThreadQueue.isHardStopQueue", command) {
            context.queue.cancelAllOperations()
            return nil
        }
        if try! IoC.resolve("ThreadQueue.isRunQueue", command) {
            return ThreadQueueStateReady(context: context)
        }
        return self
    }
}

