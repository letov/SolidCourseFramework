//
//  SolidCourseFrameworkTests.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 22.12.2021.
//

import XCTest
import Cuckoo
import simd
@testable import SolidCourseFramework

extension simd_int2: Matchable {
    public typealias MatchedType = simd_int2
}

class SolidCourseFrameworkTests: XCTestCase {
    
    var sut1: MockUObject!
    var sut2: MockUObject!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut1 = MockUObject()
        sut2 = MockUObject()
        GlobalRegister.register()
    }

    override func tearDownWithError() throws {
        sut1 = nil
        sut2 = nil
        try super.tearDownWithError()
    }
    
    // Command
    
    func fillUObjectMove(sut: MockUObject!) {
        stub(sut) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(5, 8))
            }
        }
    }
    
    func fillUObjectFuel(sut: MockUObject!) {
        stub(sut) { mock in
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 10, canChange: true))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 3, canChange: false))
            when(mock.setProperty(propertyName: "FuelReserve", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as! Int, 7)
            }
        }
    }
    
    func fillFailUObjectMove(sut: MockUObject!) {
        stub(sut) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: false))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
        }
    }
    
    func getMoveCommand(sut: MockUObject!) -> Command {
        fillUObjectMove(sut: sut)
        let adapter = MovableAdapter(m: sut)
        return MoveCommand(m: adapter)
    }
    
    func getFailMoveCommand(sut: MockUObject!) -> Command {
        fillFailUObjectMove(sut: sut)
        let adapter = MovableAdapter(m: sut)
        return MoveCommand(m: adapter)
    }

    func testMoveCommand() throws {
        let cmd = getMoveCommand(sut: sut1)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).getProperty(propertyName: "Position")
        verify(sut1).getProperty(propertyName: "Velocity")
        verify(sut1).setProperty(propertyName: "Position", propertyValue: any())
    }

    func testFailMoveCommand1() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
        }
        let adapter = MovableAdapter(m: sut1)
        let cmd = MoveCommand(m: adapter)
        XCTAssertThrowsError(try cmd.execute())
    }
    
    func testFailMoveCommand2() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
        }
        let adapter = MovableAdapter(m: sut1)
        let cmd = MoveCommand(m: adapter)
        XCTAssertThrowsError(try cmd.execute())
    }
    
    func testFailMoveCommand3() throws {
        let cmd = getFailMoveCommand(sut: sut1)
        XCTAssertThrowsError(try cmd.execute())
    }
    
    func testRotateCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Direction")).thenReturn((value: 360, canChange: true))
            when(mock.getProperty(propertyName: "AngularVelocity")).thenReturn((value: 16, canChange: true))
            when(mock.getProperty(propertyName: "MaxDirection")).thenReturn((value: 360, canChange: true))
            when(mock.setProperty(propertyName: "Direction", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? Int, 16)
            }
        }
        let adapter = RotateAdapter(r: sut1)
        let cmd = RotateCommand(r: adapter)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).getProperty(propertyName: "Direction")
        verify(sut1).getProperty(propertyName: "AngularVelocity")
        verify(sut1).getProperty(propertyName: "MaxDirection")
        verify(sut1).setProperty(propertyName: "Direction", propertyValue: any())
    }
    
    // IoC
    
    func testIoCRegisterResolve() throws {
        fillUObjectMove(sut: sut1)
        try (IoC.register("Adapter.Movable") {
            MovableAdapter(m: $0[0] as! UObject)
        } as Command).execute()
        try (IoC.register("Command.Move") {
            MoveCommand(m: try IoC.resolve("Adapter.Movable", $0[0]))
        } as Command).execute()
        XCTAssertNoThrow(try (try IoC.resolve("Command.Move", sut1!) as Command).execute())
        verify(sut1).setProperty(propertyName: "Position", propertyValue: any())
    }
    
    func testIoCScope() throws {
        fillUObjectMove(sut: sut1)
        fillUObjectMove(sut: sut2)
        try (IoC.register("Adapter.Movable") {
            MovableAdapter(m: $0[0] as! UObject)
        } as Command).execute()
        try (IoC.register("Command.Move") {
            MoveCommand(m: try IoC.resolve("Adapter.Movable", $0[0]))
        } as Command).execute()
        try (IoC.resolve("Change.Scope", "Th1") as Command).execute()
        try (IoC.register("SubQueue.Command") {
            let q = Queue<Command>()
            for _ in 0...4 {
                q.queue(try (IoC.resolve("Command.Move", $0[0]) as Command))
            }
            return q
        } as Command).execute()
        try (IoC.resolve("Change.Scope", "Root") as Command).execute()
        try (IoC.resolve("Change.Scope", "Th2") as Command).execute()
        try (IoC.register("SubQueue.Command") {
            let q = Queue<Command>()
            for _ in 0...2 {
                q.queue(try (IoC.resolve("Command.Move", $0[0]) as Command))
            }
            return q
        } as Command).execute()
        var i = 0
        Thread {
            try! (IoC.resolve("Change.Scope", "Th1") as Command).execute()
            let q = (try! IoC.resolve("SubQueue.Command", self.sut1!) as Queue<Command>)
            while !q.isEmpty() {
                try! (q.dequeue()!).execute()
            }
            i += 1
        } .start()
        Thread {
            try! (IoC.resolve("Change.Scope", "Th2") as Command).execute()
            let q = (try! IoC.resolve("SubQueue.Command", self.sut2!) as Queue<Command>)
            while !q.isEmpty() {
                try! (q.dequeue()!).execute()
            }
            i += 1
        } .start()
        while i < 2 {}
        verify(sut1, times(5)).setProperty(propertyName: "Position", propertyValue: any())
        verify(sut2, times(3)).setProperty(propertyName: "Position", propertyValue: any())
    }
}

