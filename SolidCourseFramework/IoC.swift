//
//  IoC.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 22.01.2022.
//

import Foundation

protocol StrategyStorage {
    typealias Strategy = ([Any]) throws -> Any
    func addStrategy(key: String, strategy: @escaping Strategy)
    func getStrategy(key: String) -> Strategy?
}

protocol IoCProtocol {
    typealias Strategy = ([Any]) throws -> Any
    static func register<T>(_ args: Any..., strategy: @escaping Strategy) throws -> T
    static func resolve<T>(_ args: Any...) throws -> T
}

class ScopeNode: StrategyStorage {
    let nodeName: String
    let parent: ScopeNode?
    var children = [ScopeNode]()
    var strategies = Dictionary<String, Strategy>()
    init(nodeName: String, parent: ScopeNode?) {
        self.nodeName = nodeName
        self.parent = parent
    }
    func getStrategy(key: String) -> Strategy? {
        return getStrategy(key: key, node: self)
    }
    func addStrategy(key: String, strategy: @escaping Strategy) {
        strategies[key] = strategy
    }
    func getStrategy(key: String, node: ScopeNode) -> Strategy? {
        if let result = node.strategies[key] {
            return result
        }
        if node.parent == nil {
            return nil
        }
        return getStrategy(key: key, node: node.parent!)
    }
    func addNodeChild(nodeName: String) -> ScopeNode {
        let node = ScopeNode(nodeName: nodeName, parent: self)
        children.append(node)
        return node
    }
    func getRootNode(node: ScopeNode) -> ScopeNode {
        if node.parent == nil {
            return node
        }
        return getRootNode(node: node.parent!)
    }
    func findNode(nodeName: String) -> ScopeNode? {
        return findNode(nodeName: nodeName, node: getRootNode(node: self))
    }
    func findNode(nodeName: String, node: ScopeNode) -> ScopeNode? {
        if node.nodeName == nodeName {
            return node
        }
        for child in node.children {
            if let node = findNode(nodeName: nodeName, node: child) {
                return node
            }
        }
        return nil
    }
}

class IoC: IoCProtocol {
    class IoCCommand: Command {
        typealias F = () -> ()
        var f: F
        init(f: @escaping F) {
            self.f = f
        }
        func execute() throws {
            f()
        }
    }
    static var scopeTree = ScopeNode(nodeName: "Root", parent: nil)
    static func register<T>(_ args: Any..., strategy: @escaping Strategy) throws -> T {
        guard args.count > 0, let key = args[0] as? String else {
            throw ErrorList.ioCException
        }
        guard let result = IoCCommand(f: { scopeTree.addStrategy(key: key, strategy: strategy) }) as? T else {
            throw ErrorList.ioCException
        }
        return result
    }
    static func resolve<T>(_ args: Any...) throws -> T {
        guard args.count > 0, let key = args[0] as? String else {
            throw ErrorList.ioCException
        }
        if key == "Change.Scope" {
            guard args.count > 1, let nodeName = args[1] as? String else {
                throw ErrorList.ioCException
            }
            guard let result = IoCCommand(f: {
                if let existNode = scopeTree.findNode(nodeName: nodeName) {
                    scopeTree = existNode
                } else {
                    scopeTree = scopeTree.addNodeChild(nodeName: nodeName)
                }
            }) as? T else {
                throw ErrorList.ioCException
            }
            return result
        }
        guard let strategy = scopeTree.getStrategy(key: key) else {
            throw ErrorList.ioCException
        }
        let args = args.count == 1 ? [] : Array(args[1...])
        do {
            guard let result = try strategy(args) as? T else {
                throw ErrorList.ioCException
            }
            return result
        } catch {
            throw ErrorList.ioCException
        }
    }
}
