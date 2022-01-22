// MARK: - Mocks generated from file: SolidCourseFramework/SolidCourseFramework.swift at 2022-01-22 18:26:22 +0000

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

