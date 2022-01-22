// MARK: - Mocks generated from file: SolidCourseFramework/SolidCourseFramework.swift at 2022-01-20 13:31:43 +0000

//
//  SolidCourseFramework.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 22.
import Cuckoo
@testable import SolidCourseFramework

import Foundation
import simd


 class MockUObject: UObject, Cuckoo.ProtocolMock {
    
     typealias MocksType = UObject
    
     typealias Stubbing = __StubbingProxy_UObject
     typealias Verification = __VerificationProxy_UObject

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: UObject?

     func enableDefaultImplementation(_ stub: UObject) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getProperty(propertyName: String) throws -> PropertyValue<Any> {
        
    return try cuckoo_manager.callThrows("getProperty(propertyName: String) throws -> PropertyValue<Any>",
            parameters: (propertyName),
            escapingParameters: (propertyName),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getProperty(propertyName: propertyName))
        
    }
    
    
    
     func setProperty(propertyName: String, propertyValue: PropertyValue<Any>)  {
        
    return cuckoo_manager.call("setProperty(propertyName: String, propertyValue: PropertyValue<Any>)",
            parameters: (propertyName, propertyValue),
            escapingParameters: (propertyName, propertyValue),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setProperty(propertyName: propertyName, propertyValue: propertyValue))
        
    }
    

	 struct __StubbingProxy_UObject: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getProperty<M1: Cuckoo.Matchable>(propertyName: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), PropertyValue<Any>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: propertyName) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUObject.self, method: "getProperty(propertyName: String) throws -> PropertyValue<Any>", parameterMatchers: matchers))
	    }
	    
	    func setProperty<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(propertyName: M1, propertyValue: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, PropertyValue<Any>)> where M1.MatchedType == String, M2.MatchedType == PropertyValue<Any> {
	        let matchers: [Cuckoo.ParameterMatcher<(String, PropertyValue<Any>)>] = [wrap(matchable: propertyName) { $0.0 }, wrap(matchable: propertyValue) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUObject.self, method: "setProperty(propertyName: String, propertyValue: PropertyValue<Any>)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_UObject: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getProperty<M1: Cuckoo.Matchable>(propertyName: M1) -> Cuckoo.__DoNotUse<(String), PropertyValue<Any>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: propertyName) { $0 }]
	        return cuckoo_manager.verify("getProperty(propertyName: String) throws -> PropertyValue<Any>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setProperty<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(propertyName: M1, propertyValue: M2) -> Cuckoo.__DoNotUse<(String, PropertyValue<Any>), Void> where M1.MatchedType == String, M2.MatchedType == PropertyValue<Any> {
	        let matchers: [Cuckoo.ParameterMatcher<(String, PropertyValue<Any>)>] = [wrap(matchable: propertyName) { $0.0 }, wrap(matchable: propertyValue) { $0.1 }]
	        return cuckoo_manager.verify("setProperty(propertyName: String, propertyValue: PropertyValue<Any>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class UObjectStub: UObject {
    

    

    
     func getProperty(propertyName: String) throws -> PropertyValue<Any>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Any>).self)
    }
    
     func setProperty(propertyName: String, propertyValue: PropertyValue<Any>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockCommand: Command, Cuckoo.ProtocolMock {
    
     typealias MocksType = Command
    
     typealias Stubbing = __StubbingProxy_Command
     typealias Verification = __VerificationProxy_Command

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Command?

     func enableDefaultImplementation(_ stub: Command) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	 struct __StubbingProxy_Command: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCommand.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Command: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CommandStub: Command {
    

    

    
     func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockMovable: Movable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Movable
    
     typealias Stubbing = __StubbingProxy_Movable
     typealias Verification = __VerificationProxy_Movable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Movable?

     func enableDefaultImplementation(_ stub: Movable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getPosition() throws -> PropertyValue<simd_int2> {
        
    return try cuckoo_manager.callThrows("getPosition() throws -> PropertyValue<simd_int2>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPosition())
        
    }
    
    
    
     func getVelocity() throws -> PropertyValue<simd_int2> {
        
    return try cuckoo_manager.callThrows("getVelocity() throws -> PropertyValue<simd_int2>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getVelocity())
        
    }
    
    
    
     func setPosition(position: PropertyValue<simd_int2>)  {
        
    return cuckoo_manager.call("setPosition(position: PropertyValue<simd_int2>)",
            parameters: (position),
            escapingParameters: (position),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setPosition(position: position))
        
    }
    

	 struct __StubbingProxy_Movable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getPosition() -> Cuckoo.ProtocolStubThrowingFunction<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMovable.self, method: "getPosition() throws -> PropertyValue<simd_int2>", parameterMatchers: matchers))
	    }
	    
	    func getVelocity() -> Cuckoo.ProtocolStubThrowingFunction<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMovable.self, method: "getVelocity() throws -> PropertyValue<simd_int2>", parameterMatchers: matchers))
	    }
	    
	    func setPosition<M1: Cuckoo.Matchable>(position: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(PropertyValue<simd_int2>)> where M1.MatchedType == PropertyValue<simd_int2> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<simd_int2>)>] = [wrap(matchable: position) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovable.self, method: "setPosition(position: PropertyValue<simd_int2>)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Movable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getPosition() -> Cuckoo.__DoNotUse<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getPosition() throws -> PropertyValue<simd_int2>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getVelocity() -> Cuckoo.__DoNotUse<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getVelocity() throws -> PropertyValue<simd_int2>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setPosition<M1: Cuckoo.Matchable>(position: M1) -> Cuckoo.__DoNotUse<(PropertyValue<simd_int2>), Void> where M1.MatchedType == PropertyValue<simd_int2> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<simd_int2>)>] = [wrap(matchable: position) { $0 }]
	        return cuckoo_manager.verify("setPosition(position: PropertyValue<simd_int2>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MovableStub: Movable {
    

    

    
     func getPosition() throws -> PropertyValue<simd_int2>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<simd_int2>).self)
    }
    
     func getVelocity() throws -> PropertyValue<simd_int2>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<simd_int2>).self)
    }
    
     func setPosition(position: PropertyValue<simd_int2>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockMoveCommand: MoveCommand, Cuckoo.ClassMock {
    
     typealias MocksType = MoveCommand
    
     typealias Stubbing = __StubbingProxy_MoveCommand
     typealias Verification = __VerificationProxy_MoveCommand

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MoveCommand?

     func enableDefaultImplementation(_ stub: MoveCommand) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.execute()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	 struct __StubbingProxy_MoveCommand: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveCommand.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MoveCommand: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MoveCommandStub: MoveCommand {
    

    

    
     override func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockMovableAdapter: MovableAdapter, Cuckoo.ClassMock {
    
     typealias MocksType = MovableAdapter
    
     typealias Stubbing = __StubbingProxy_MovableAdapter
     typealias Verification = __VerificationProxy_MovableAdapter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MovableAdapter?

     func enableDefaultImplementation(_ stub: MovableAdapter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getPosition() throws -> PropertyValue<simd_int2> {
        
    return try cuckoo_manager.callThrows("getPosition() throws -> PropertyValue<simd_int2>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getPosition()
                ,
            defaultCall: __defaultImplStub!.getPosition())
        
    }
    
    
    
     override func getVelocity() throws -> PropertyValue<simd_int2> {
        
    return try cuckoo_manager.callThrows("getVelocity() throws -> PropertyValue<simd_int2>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getVelocity()
                ,
            defaultCall: __defaultImplStub!.getVelocity())
        
    }
    
    
    
     override func setPosition(position: PropertyValue<simd_int2>)  {
        
    return cuckoo_manager.call("setPosition(position: PropertyValue<simd_int2>)",
            parameters: (position),
            escapingParameters: (position),
            superclassCall:
                
                super.setPosition(position: position)
                ,
            defaultCall: __defaultImplStub!.setPosition(position: position))
        
    }
    

	 struct __StubbingProxy_MovableAdapter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getPosition() -> Cuckoo.ClassStubThrowingFunction<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMovableAdapter.self, method: "getPosition() throws -> PropertyValue<simd_int2>", parameterMatchers: matchers))
	    }
	    
	    func getVelocity() -> Cuckoo.ClassStubThrowingFunction<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMovableAdapter.self, method: "getVelocity() throws -> PropertyValue<simd_int2>", parameterMatchers: matchers))
	    }
	    
	    func setPosition<M1: Cuckoo.Matchable>(position: M1) -> Cuckoo.ClassStubNoReturnFunction<(PropertyValue<simd_int2>)> where M1.MatchedType == PropertyValue<simd_int2> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<simd_int2>)>] = [wrap(matchable: position) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMovableAdapter.self, method: "setPosition(position: PropertyValue<simd_int2>)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MovableAdapter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getPosition() -> Cuckoo.__DoNotUse<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getPosition() throws -> PropertyValue<simd_int2>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getVelocity() -> Cuckoo.__DoNotUse<(), PropertyValue<simd_int2>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getVelocity() throws -> PropertyValue<simd_int2>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setPosition<M1: Cuckoo.Matchable>(position: M1) -> Cuckoo.__DoNotUse<(PropertyValue<simd_int2>), Void> where M1.MatchedType == PropertyValue<simd_int2> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<simd_int2>)>] = [wrap(matchable: position) { $0 }]
	        return cuckoo_manager.verify("setPosition(position: PropertyValue<simd_int2>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MovableAdapterStub: MovableAdapter {
    

    

    
     override func getPosition() throws -> PropertyValue<simd_int2>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<simd_int2>).self)
    }
    
     override func getVelocity() throws -> PropertyValue<simd_int2>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<simd_int2>).self)
    }
    
     override func setPosition(position: PropertyValue<simd_int2>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockRotable: Rotable, Cuckoo.ProtocolMock {
    
     typealias MocksType = Rotable
    
     typealias Stubbing = __StubbingProxy_Rotable
     typealias Verification = __VerificationProxy_Rotable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Rotable?

     func enableDefaultImplementation(_ stub: Rotable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getDirection() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getDirection() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getDirection())
        
    }
    
    
    
     func setDirection(direction: PropertyValue<Int>)  {
        
    return cuckoo_manager.call("setDirection(direction: PropertyValue<Int>)",
            parameters: (direction),
            escapingParameters: (direction),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setDirection(direction: direction))
        
    }
    
    
    
     func getAngularVelocity() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getAngularVelocity() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getAngularVelocity())
        
    }
    
    
    
     func getMaxDirection() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getMaxDirection() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMaxDirection())
        
    }
    

	 struct __StubbingProxy_Rotable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getDirection() -> Cuckoo.ProtocolStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotable.self, method: "getDirection() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	    func setDirection<M1: Cuckoo.Matchable>(direction: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(PropertyValue<Int>)> where M1.MatchedType == PropertyValue<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<Int>)>] = [wrap(matchable: direction) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRotable.self, method: "setDirection(direction: PropertyValue<Int>)", parameterMatchers: matchers))
	    }
	    
	    func getAngularVelocity() -> Cuckoo.ProtocolStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotable.self, method: "getAngularVelocity() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	    func getMaxDirection() -> Cuckoo.ProtocolStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotable.self, method: "getMaxDirection() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Rotable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getDirection() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDirection() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setDirection<M1: Cuckoo.Matchable>(direction: M1) -> Cuckoo.__DoNotUse<(PropertyValue<Int>), Void> where M1.MatchedType == PropertyValue<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<Int>)>] = [wrap(matchable: direction) { $0 }]
	        return cuckoo_manager.verify("setDirection(direction: PropertyValue<Int>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getAngularVelocity() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getAngularVelocity() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMaxDirection() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getMaxDirection() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RotableStub: Rotable {
    

    

    
     func getDirection() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
     func setDirection(direction: PropertyValue<Int>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getAngularVelocity() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
     func getMaxDirection() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
}



 class MockRotateCommand: RotateCommand, Cuckoo.ClassMock {
    
     typealias MocksType = RotateCommand
    
     typealias Stubbing = __StubbingProxy_RotateCommand
     typealias Verification = __VerificationProxy_RotateCommand

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: RotateCommand?

     func enableDefaultImplementation(_ stub: RotateCommand) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func execute() throws {
        
    return try cuckoo_manager.callThrows("execute() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.execute()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	 struct __StubbingProxy_RotateCommand: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotateCommand.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_RotateCommand: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RotateCommandStub: RotateCommand {
    

    

    
     override func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockRotateAdapter: RotateAdapter, Cuckoo.ClassMock {
    
     typealias MocksType = RotateAdapter
    
     typealias Stubbing = __StubbingProxy_RotateAdapter
     typealias Verification = __VerificationProxy_RotateAdapter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: RotateAdapter?

     func enableDefaultImplementation(_ stub: RotateAdapter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getDirection() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getDirection() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getDirection()
                ,
            defaultCall: __defaultImplStub!.getDirection())
        
    }
    
    
    
     override func getAngularVelocity() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getAngularVelocity() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getAngularVelocity()
                ,
            defaultCall: __defaultImplStub!.getAngularVelocity())
        
    }
    
    
    
     override func getMaxDirection() throws -> PropertyValue<Int> {
        
    return try cuckoo_manager.callThrows("getMaxDirection() throws -> PropertyValue<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getMaxDirection()
                ,
            defaultCall: __defaultImplStub!.getMaxDirection())
        
    }
    
    
    
     override func setDirection(direction: PropertyValue<Int>)  {
        
    return cuckoo_manager.call("setDirection(direction: PropertyValue<Int>)",
            parameters: (direction),
            escapingParameters: (direction),
            superclassCall:
                
                super.setDirection(direction: direction)
                ,
            defaultCall: __defaultImplStub!.setDirection(direction: direction))
        
    }
    

	 struct __StubbingProxy_RotateAdapter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getDirection() -> Cuckoo.ClassStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotateAdapter.self, method: "getDirection() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	    func getAngularVelocity() -> Cuckoo.ClassStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotateAdapter.self, method: "getAngularVelocity() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	    func getMaxDirection() -> Cuckoo.ClassStubThrowingFunction<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRotateAdapter.self, method: "getMaxDirection() throws -> PropertyValue<Int>", parameterMatchers: matchers))
	    }
	    
	    func setDirection<M1: Cuckoo.Matchable>(direction: M1) -> Cuckoo.ClassStubNoReturnFunction<(PropertyValue<Int>)> where M1.MatchedType == PropertyValue<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<Int>)>] = [wrap(matchable: direction) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRotateAdapter.self, method: "setDirection(direction: PropertyValue<Int>)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_RotateAdapter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getDirection() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDirection() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getAngularVelocity() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getAngularVelocity() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMaxDirection() -> Cuckoo.__DoNotUse<(), PropertyValue<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getMaxDirection() throws -> PropertyValue<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setDirection<M1: Cuckoo.Matchable>(direction: M1) -> Cuckoo.__DoNotUse<(PropertyValue<Int>), Void> where M1.MatchedType == PropertyValue<Int> {
	        let matchers: [Cuckoo.ParameterMatcher<(PropertyValue<Int>)>] = [wrap(matchable: direction) { $0 }]
	        return cuckoo_manager.verify("setDirection(direction: PropertyValue<Int>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RotateAdapterStub: RotateAdapter {
    

    

    
     override func getDirection() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
     override func getAngularVelocity() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
     override func getMaxDirection() throws -> PropertyValue<Int>  {
        return DefaultValueRegistry.defaultValue(for: (PropertyValue<Int>).self)
    }
    
     override func setDirection(direction: PropertyValue<Int>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

