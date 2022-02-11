// MARK: - Mocks generated from file: SolidCourseFramework/SolidCourseFramework.swift at 2022-02-11 21:39:52 +0000

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



 class MockAdapter: Adapter, Cuckoo.ProtocolMock {
    
     typealias MocksType = Adapter
    
     typealias Stubbing = __StubbingProxy_Adapter
     typealias Verification = __VerificationProxy_Adapter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Adapter?

     func enableDefaultImplementation(_ stub: Adapter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var o: UObject {
        get {
            return cuckoo_manager.getter("o",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.o)
        }
        
        set {
            cuckoo_manager.setter("o",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.o = newValue)
        }
        
    }
    

    
    
     required init(o: UObject) {
        
    }
    

    
    
    
     func setAdditionMethods(_ args: [FType])  {
        
    return cuckoo_manager.call("setAdditionMethods(_: [FType])",
            parameters: (args),
            escapingParameters: (args),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setAdditionMethods(args))
        
    }
    

	 struct __StubbingProxy_Adapter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var o: Cuckoo.ProtocolToBeStubbedProperty<MockAdapter, UObject> {
	        return .init(manager: cuckoo_manager, name: "o")
	    }
	    
	    
	    func setAdditionMethods<M1: Cuckoo.Matchable>(_ args: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([FType])> where M1.MatchedType == [FType] {
	        let matchers: [Cuckoo.ParameterMatcher<([FType])>] = [wrap(matchable: args) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAdapter.self, method: "setAdditionMethods(_: [FType])", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Adapter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var o: Cuckoo.VerifyProperty<UObject> {
	        return .init(manager: cuckoo_manager, name: "o", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setAdditionMethods<M1: Cuckoo.Matchable>(_ args: M1) -> Cuckoo.__DoNotUse<([FType]), Void> where M1.MatchedType == [FType] {
	        let matchers: [Cuckoo.ParameterMatcher<([FType])>] = [wrap(matchable: args) { $0 }]
	        return cuckoo_manager.verify("setAdditionMethods(_: [FType])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AdapterStub: Adapter {
    
    
     var o: UObject {
        get {
            return DefaultValueRegistry.defaultValue(for: (UObject).self)
        }
        
        set { }
        
    }
    

    
     required init(o: UObject) {
        
    }
    

    
     func setAdditionMethods(_ args: [FType])   {
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



 class MockMacroCommand: MacroCommand, Cuckoo.ClassMock {
    
     typealias MocksType = MacroCommand
    
     typealias Stubbing = __StubbingProxy_MacroCommand
     typealias Verification = __VerificationProxy_MacroCommand

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MacroCommand?

     func enableDefaultImplementation(_ stub: MacroCommand) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var commands: Array<Command> {
        get {
            return cuckoo_manager.getter("commands",
                superclassCall:
                    
                    super.commands
                    ,
                defaultCall: __defaultImplStub!.commands)
        }
        
        set {
            cuckoo_manager.setter("commands",
                value: newValue,
                superclassCall:
                    
                    super.commands = newValue
                    ,
                defaultCall: __defaultImplStub!.commands = newValue)
        }
        
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
    

	 struct __StubbingProxy_MacroCommand: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var commands: Cuckoo.ClassToBeStubbedProperty<MockMacroCommand, Array<Command>> {
	        return .init(manager: cuckoo_manager, name: "commands")
	    }
	    
	    
	    func execute() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMacroCommand.self, method: "execute() throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MacroCommand: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var commands: Cuckoo.VerifyProperty<Array<Command>> {
	        return .init(manager: cuckoo_manager, name: "commands", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MacroCommandStub: MacroCommand {
    
    
     override var commands: Array<Command> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Array<Command>).self)
        }
        
        set { }
        
    }
    

    

    
     override func execute() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAdapterList: AdapterList, Cuckoo.ClassMock {
    
     typealias MocksType = AdapterList
    
     typealias Stubbing = __StubbingProxy_AdapterList
     typealias Verification = __VerificationProxy_AdapterList

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: AdapterList?

     func enableDefaultImplementation(_ stub: AdapterList) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var table: Dictionary<String, Adapter.Type> {
        get {
            return cuckoo_manager.getter("table",
                superclassCall:
                    
                    super.table
                    ,
                defaultCall: __defaultImplStub!.table)
        }
        
        set {
            cuckoo_manager.setter("table",
                value: newValue,
                superclassCall:
                    
                    super.table = newValue
                    ,
                defaultCall: __defaultImplStub!.table = newValue)
        }
        
    }
    

    

    
    
    
     override func getKey(_ a: Any) -> String {
        
    return cuckoo_manager.call("getKey(_: Any) -> String",
            parameters: (a),
            escapingParameters: (a),
            superclassCall:
                
                super.getKey(a)
                ,
            defaultCall: __defaultImplStub!.getKey(a))
        
    }
    

	 struct __StubbingProxy_AdapterList: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var table: Cuckoo.ClassToBeStubbedProperty<MockAdapterList, Dictionary<String, Adapter.Type>> {
	        return .init(manager: cuckoo_manager, name: "table")
	    }
	    
	    
	    func getKey<M1: Cuckoo.Matchable>(_ a: M1) -> Cuckoo.ClassStubFunction<(Any), String> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: a) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAdapterList.self, method: "getKey(_: Any) -> String", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AdapterList: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var table: Cuckoo.VerifyProperty<Dictionary<String, Adapter.Type>> {
	        return .init(manager: cuckoo_manager, name: "table", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func getKey<M1: Cuckoo.Matchable>(_ a: M1) -> Cuckoo.__DoNotUse<(Any), String> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: a) { $0 }]
	        return cuckoo_manager.verify("getKey(_: Any) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AdapterListStub: AdapterList {
    
    
     override var table: Dictionary<String, Adapter.Type> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Dictionary<String, Adapter.Type>).self)
        }
        
        set { }
        
    }
    

    

    
     override func getKey(_ a: Any) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
}



 class MockGlobalRegister: GlobalRegister, Cuckoo.ClassMock {
    
     typealias MocksType = GlobalRegister
    
     typealias Stubbing = __StubbingProxy_GlobalRegister
     typealias Verification = __VerificationProxy_GlobalRegister

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GlobalRegister?

     func enableDefaultImplementation(_ stub: GlobalRegister) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

	 struct __StubbingProxy_GlobalRegister: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	}

	 struct __VerificationProxy_GlobalRegister: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	}
}

 class GlobalRegisterStub: GlobalRegister {
    

    

    
}

