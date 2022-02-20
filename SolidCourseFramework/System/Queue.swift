//
//  Queue.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation
 
protocol QueueStorageProtocol {
    associatedtype T
    func isEmpty() -> Bool
    func queue(_ elem: T)
    func dequeue() -> T?
    func removeAll()
}

class QueueLinkedList<T>: QueueStorageProtocol {
    class Node {
        var value: T
        var next: Node?
        init(value: T, next: Node?) {
            self.value = value
            self.next = next
        }
    }
    var head: Node?
    var tail: Node?
    func isEmpty() -> Bool {
        return head == nil
    }
    func queue(_ value: T) {
        if head == nil {
            head = Node(value: value, next: nil)
            tail = head
            return
        }
        tail!.next = Node(value: value, next: nil)
        tail = tail!.next
    }
    func dequeue() -> T? {
        if head == nil {
            return nil
        }
        let value = head!.value
        head = head!.next
        return value
    }
    func removeAll() {
        head = nil
    }
}

protocol QueueProtocol {
    associatedtype T
    associatedtype QueryStorage: QueueStorageProtocol
    var queue: QueryStorage { get set }
    func isEmpty() -> Bool
    func queue(_ value: T)
    func dequeue() -> T?
    func removeAll()
}

class Queue<T>: QueueProtocol {
    typealias QueryStorage = QueueLinkedList<T>
    var queue: QueryStorage = QueryStorage()
    typealias HistoryRow = (time: DispatchTime, value: T)
    var history = Array<HistoryRow>()
    func historyReversed(_ i: Int) -> T? {
        let revercedIndex = (history.count - 1) - i
        guard revercedIndex >= 0 else {
            return nil
        }
        return history[revercedIndex].value as T
    }
    func isEmpty() -> Bool {
        return queue.isEmpty()
    }
    func queue(_ value: T) {
        queue.queue(value)
        history.append((time: DispatchTime.now(), value: value))
    }
    func dequeue() -> T? {
        return queue.dequeue()
    }
    func removeAll() {
        queue.removeAll()
        history.removeAll()
    }
}
