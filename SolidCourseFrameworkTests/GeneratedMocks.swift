// MARK: - Mocks generated from file: SolidCourseFramework/System/Common.swift at 2022-03-26 09:02:41 +0000

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
    

    

    
    
    
     override func getAll() -> [String] {
        
    return cuckoo_manager.call("getAll() -> [String]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getAll()
                ,
            defaultCall: __defaultImplStub!.getAll())
        
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
	    
	    
	    func getAll() -> Cuckoo.ClassStubFunction<(), [String]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAdapterList.self, method: "getAll() -> [String]", parameterMatchers: matchers))
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
	    func getAll() -> Cuckoo.__DoNotUse<(), [String]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getAll() -> [String]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
    
    
     override func getAll() -> [String]  {
        return DefaultValueRegistry.defaultValue(for: ([String]).self)
    }
    
    
    
     override func getKey(_ a: Any) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
}



 class MockObjectList: ObjectList, Cuckoo.ClassMock {
    
     typealias MocksType = ObjectList
    
     typealias Stubbing = __StubbingProxy_ObjectList
     typealias Verification = __VerificationProxy_ObjectList

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ObjectList?

     func enableDefaultImplementation(_ stub: ObjectList) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var table: [UObject] {
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
    

    

    
    
    
     override func append(_ o: UObject)  {
        
    return cuckoo_manager.call("append(_: UObject)",
            parameters: (o),
            escapingParameters: (o),
            superclassCall:
                
                super.append(o)
                ,
            defaultCall: __defaultImplStub!.append(o))
        
    }
    

	 struct __StubbingProxy_ObjectList: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var table: Cuckoo.ClassToBeStubbedProperty<MockObjectList, [UObject]> {
	        return .init(manager: cuckoo_manager, name: "table")
	    }
	    
	    
	    func append<M1: Cuckoo.Matchable>(_ o: M1) -> Cuckoo.ClassStubNoReturnFunction<(UObject)> where M1.MatchedType == UObject {
	        let matchers: [Cuckoo.ParameterMatcher<(UObject)>] = [wrap(matchable: o) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockObjectList.self, method: "append(_: UObject)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ObjectList: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var table: Cuckoo.VerifyProperty<[UObject]> {
	        return .init(manager: cuckoo_manager, name: "table", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func append<M1: Cuckoo.Matchable>(_ o: M1) -> Cuckoo.__DoNotUse<(UObject), Void> where M1.MatchedType == UObject {
	        let matchers: [Cuckoo.ParameterMatcher<(UObject)>] = [wrap(matchable: o) { $0 }]
	        return cuckoo_manager.verify("append(_: UObject)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ObjectListStub: ObjectList {
        
    
    
     override var table: [UObject] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([UObject]).self)
        }
        
        set { }
        
    }
    

    

    
    
    
     override func append(_ o: UObject)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockCommandList: CommandList, Cuckoo.ClassMock {
    
     typealias MocksType = CommandList
    
     typealias Stubbing = __StubbingProxy_CommandList
     typealias Verification = __VerificationProxy_CommandList

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: CommandList?

     func enableDefaultImplementation(_ stub: CommandList) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var table: [Command.Type] {
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
    

    

    
    
    
     override func append(_ command: Command.Type)  {
        
    return cuckoo_manager.call("append(_: Command.Type)",
            parameters: (command),
            escapingParameters: (command),
            superclassCall:
                
                super.append(command)
                ,
            defaultCall: __defaultImplStub!.append(command))
        
    }
    

	 struct __StubbingProxy_CommandList: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var table: Cuckoo.ClassToBeStubbedProperty<MockCommandList, [Command.Type]> {
	        return .init(manager: cuckoo_manager, name: "table")
	    }
	    
	    
	    func append<M1: Cuckoo.Matchable>(_ command: M1) -> Cuckoo.ClassStubNoReturnFunction<(Command.Type)> where M1.MatchedType == Command.Type {
	        let matchers: [Cuckoo.ParameterMatcher<(Command.Type)>] = [wrap(matchable: command) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCommandList.self, method: "append(_: Command.Type)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CommandList: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var table: Cuckoo.VerifyProperty<[Command.Type]> {
	        return .init(manager: cuckoo_manager, name: "table", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func append<M1: Cuckoo.Matchable>(_ command: M1) -> Cuckoo.__DoNotUse<(Command.Type), Void> where M1.MatchedType == Command.Type {
	        let matchers: [Cuckoo.ParameterMatcher<(Command.Type)>] = [wrap(matchable: command) { $0 }]
	        return cuckoo_manager.verify("append(_: Command.Type)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CommandListStub: CommandList {
        
    
    
     override var table: [Command.Type] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([Command.Type]).self)
        }
        
        set { }
        
    }
    

    

    
    
    
     override func append(_ command: Command.Type)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockGame: Game, Cuckoo.ClassMock {
    
     typealias MocksType = Game
    
     typealias Stubbing = __StubbingProxy_Game
     typealias Verification = __VerificationProxy_Game

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Game?

     func enableDefaultImplementation(_ stub: Game) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var userIds: Set<Int> {
        get {
            return cuckoo_manager.getter("userIds",
                superclassCall:
                    
                    super.userIds
                    ,
                defaultCall: __defaultImplStub!.userIds)
        }
        
        set {
            cuckoo_manager.setter("userIds",
                value: newValue,
                superclassCall:
                    
                    super.userIds = newValue
                    ,
                defaultCall: __defaultImplStub!.userIds = newValue)
        }
        
    }
    

    

    
    
    
     override func hasUser(userId: Int) -> Bool {
        
    return cuckoo_manager.call("hasUser(userId: Int) -> Bool",
            parameters: (userId),
            escapingParameters: (userId),
            superclassCall:
                
                super.hasUser(userId: userId)
                ,
            defaultCall: __defaultImplStub!.hasUser(userId: userId))
        
    }
    

	 struct __StubbingProxy_Game: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var userIds: Cuckoo.ClassToBeStubbedProperty<MockGame, Set<Int>> {
	        return .init(manager: cuckoo_manager, name: "userIds")
	    }
	    
	    
	    func hasUser<M1: Cuckoo.Matchable>(userId: M1) -> Cuckoo.ClassStubFunction<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: userId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGame.self, method: "hasUser(userId: Int) -> Bool", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Game: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var userIds: Cuckoo.VerifyProperty<Set<Int>> {
	        return .init(manager: cuckoo_manager, name: "userIds", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func hasUser<M1: Cuckoo.Matchable>(userId: M1) -> Cuckoo.__DoNotUse<(Int), Bool> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: userId) { $0 }]
	        return cuckoo_manager.verify("hasUser(userId: Int) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameStub: Game {
        
    
    
     override var userIds: Set<Int> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Set<Int>).self)
        }
        
        set { }
        
    }
    

    

    
    
    
     override func hasUser(userId: Int) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
}



 class MockGameList: GameList, Cuckoo.ClassMock {
    
     typealias MocksType = GameList
    
     typealias Stubbing = __StubbingProxy_GameList
     typealias Verification = __VerificationProxy_GameList

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GameList?

     func enableDefaultImplementation(_ stub: GameList) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var table: [Int: Game] {
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
    
    
    
     override var freeGameId: Int {
        get {
            return cuckoo_manager.getter("freeGameId",
                superclassCall:
                    
                    super.freeGameId
                    ,
                defaultCall: __defaultImplStub!.freeGameId)
        }
        
    }
    

    

    
    
    
     override func add(_ game: Game) -> Int {
        
    return cuckoo_manager.call("add(_: Game) -> Int",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                super.add(game)
                ,
            defaultCall: __defaultImplStub!.add(game))
        
    }
    

	 struct __StubbingProxy_GameList: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var table: Cuckoo.ClassToBeStubbedProperty<MockGameList, [Int: Game]> {
	        return .init(manager: cuckoo_manager, name: "table")
	    }
	    
	    
	    var freeGameId: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockGameList, Int> {
	        return .init(manager: cuckoo_manager, name: "freeGameId")
	    }
	    
	    
	    func add<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ClassStubFunction<(Game), Int> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameList.self, method: "add(_: Game) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameList: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var table: Cuckoo.VerifyProperty<[Int: Game]> {
	        return .init(manager: cuckoo_manager, name: "table", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var freeGameId: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "freeGameId", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func add<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Int> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("add(_: Game) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameListStub: GameList {
        
    
    
     override var table: [Int: Game] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([Int: Game]).self)
        }
        
        set { }
        
    }
        
    
    
     override var freeGameId: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
    
    
     override func add(_ game: Game) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
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

