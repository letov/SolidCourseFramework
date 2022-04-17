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
    var dbFileRandFile = String()
    
    func generateRandomString(size: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<size).map { _ in base.randomElement()!})
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut1 = MockUObject()
        sut2 = MockUObject()
        // new db file for every test
        guard let dbFile = Bundle(for: type(of: self)).path(forResource: "db", ofType: "sqlite") else {
            throw ErrorList.dbError
        }
        dbFileRandFile = dbFile.replacingOccurrences(of: "db.sqlite", with: "db\(generateRandomString()).sqlite")
        if FileManager.default.fileExists(atPath: dbFileRandFile) {
            try FileManager.default.removeItem(atPath: dbFileRandFile)
        }
        try FileManager.default.copyItem(atPath: dbFile, toPath: dbFileRandFile)
        GlobalRegister.register(dbFile: dbFileRandFile)
        let db: DBConnection = try IoC.resolve("DB")
        _ = try db.write("DELETE FROM users WHERE 1")
    }

    override func tearDownWithError() throws {
        sut1 = nil
        sut2 = nil
        if FileManager.default.fileExists(atPath: dbFileRandFile) {
            try FileManager.default.removeItem(atPath: dbFileRandFile)
        }
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
        let adapter = MovableAdapter(o: sut)
        return MoveCommand(m: adapter)
    }
    
    func getFailMoveCommand(sut: MockUObject!) -> Command {
        fillFailUObjectMove(sut: sut)
        let adapter = MovableAdapter(o: sut)
        return MoveCommand(m: adapter)
    }

    func testMoveCommand() throws {
        let cmd = getMoveCommand(sut: sut1)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).getProperty(propertyName: "Position")
        verify(sut1).getProperty(propertyName: "Velocity")
        verify(sut1).setProperty(propertyName: "Position", propertyValue: any())
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
        let adapter = RotableAdapter(o: sut1)
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
            MovableAdapter(o: $0[0] as! UObject)
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
            MovableAdapter(o: $0[0] as! UObject)
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
    
    // Exception
    
    func testExceptionLogErrorHandler() throws {
        fillFailUObjectMove(sut: sut1)

        try (IoC.register("Command.Move") {
            MoveCommand(m: MovableAdapter(o: $0[0] as! UObject))
        } as Command).execute()
        let command: Command = try IoC.resolve("Command.Move", sut1!)
        
        try (IoC.resolve("Error.Handle.List") as ErrorHandleList)[command] = "Error.Log"

        let queue: Queue<Command> = try IoC.resolve("Queue.Command")
        queue.queue(command)
        while !queue.isEmpty() {
            let cmd = queue.dequeue()!
            do {
                try cmd.execute()
            } catch {
                queue.queue(try (IoC.resolve("Error.Handle", cmd, error) as Command))
            }
        }
        XCTAssertEqual(String(describing: queue.historyReversed(1)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(0)!).components(separatedBy: ".")[1], "ErrorCommand")
    }
    
    func testExceptionRepeatAndLogErrorHandler() throws {
        fillFailUObjectMove(sut: sut1)

        try (IoC.register("Command.Move") {
            MoveCommand(m: MovableAdapter(o: $0[0] as! UObject))
        } as Command).execute()
        let command: Command = try IoC.resolve("Command.Move", sut1!)
        
        try (IoC.register("Error.Repeat") {
            ErrorCommand(command: $0[0] as! Command, error: $0[1] as! Error) { (command, _) in
                (try! IoC.resolve("Queue.Command") as Queue<Command>).queue(command)
                let errorHandleList = try! (IoC.resolve("Error.Handle.List") as ErrorHandleList)
                errorHandleList[command] = "Error.Log"
            }
        } as Command).execute()

        let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
        errorHandleList[command] = "Error.Repeat"
        
        try (IoC.register("Error.Handle") {
            let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
            return try (IoC.resolve(errorHandleList[$0[0] as! Command], $0[0], $0[1]) as Command)
        } as Command).execute()

        let queue: Queue<Command> = try IoC.resolve("Queue.Command")
        queue.queue(command)
        while !queue.isEmpty() {
            let cmd = queue.dequeue()!
            do {
                try cmd.execute()
            } catch {
                queue.queue(try (IoC.resolve("Error.Handle", cmd, error) as Command))
            }
        }
        XCTAssertEqual(String(describing: queue.historyReversed(3)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(2)!).components(separatedBy: ".")[1], "ErrorCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(1)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(0)!).components(separatedBy: ".")[1], "ErrorCommand")
    }

    func testExceptionRepeatTwiceAndLogErrorHandler() throws {
        fillFailUObjectMove(sut: sut1)

        try (IoC.register("Command.Move") {
            MoveCommand(m: MovableAdapter(o: $0[0] as! UObject))
        } as Command).execute()
        let command: Command = try IoC.resolve("Command.Move", sut1!)
        
        try (IoC.register("Error.Repeat") {
            ErrorCommand(command: $0[0] as! Command, error: $0[1] as! Error) { (command, _) in
                (try! IoC.resolve("Queue.Command") as Queue<Command>).queue(command)
                let errorHandleList = try! (IoC.resolve("Error.Handle.List") as ErrorHandleList)
                errorHandleList[command] = "Error.Log"
            }
        } as Command).execute()
        
        try (IoC.register("Error.RepeatTwice") {
            ErrorCommand(command: $0[0] as! Command, error: $0[1] as! Error) { (command, _) in
                (try! IoC.resolve("Queue.Command") as Queue<Command>).queue(command)
                let errorHandleList = try! (IoC.resolve("Error.Handle.List") as ErrorHandleList)
                errorHandleList[command] = "Error.Repeat"
            }
        } as Command).execute()

        let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
        errorHandleList[command] = "Error.RepeatTwice"
        
        try (IoC.register("Error.Handle") {
            let errorHandleList = try (IoC.resolve("Error.Handle.List") as ErrorHandleList)
            return try (IoC.resolve(errorHandleList[$0[0] as! Command], $0[0], $0[1]) as Command)
        } as Command).execute()

        let queue: Queue<Command> = try IoC.resolve("Queue.Command")
        queue.queue(command)
        while !queue.isEmpty() {
            let cmd = queue.dequeue()!
            do {
                try cmd.execute()
            } catch {
                queue.queue(try (IoC.resolve("Error.Handle", cmd, error) as Command))
            }
        }
        XCTAssertEqual(String(describing: queue.historyReversed(5)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(4)!).components(separatedBy: ".")[1], "ErrorCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(3)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(2)!).components(separatedBy: ".")[1], "ErrorCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(1)!).components(separatedBy: ".")[1], "MoveCommand")
        XCTAssertEqual(String(describing: queue.historyReversed(0)!).components(separatedBy: ".")[1], "ErrorCommand")
    }
    
    // macrocommand
    
    func testCheckFuelCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 10, canChange: false))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 1, canChange: false))
        }
        let adapter = FuelableAdapter(o: sut1)
        let cmd = CheckFuelCommand(f: adapter)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).getProperty(propertyName: "FuelReserve")
        verify(sut1).getProperty(propertyName: "FuelConsumptionRate")
    }
    
    func testFailCheckFuelCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 1, canChange: false))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 100, canChange: false))
        }
        let adapter = FuelableAdapter(o: sut1)
        let cmd = CheckFuelCommand(f: adapter)
        var error: Error?
        XCTAssertThrowsError(try cmd.execute()) {
            error = $0
        }
        XCTAssertEqual(error as! ErrorList, ErrorList.commandException)
        verify(sut1).getProperty(propertyName: "FuelReserve")
        verify(sut1).getProperty(propertyName: "FuelConsumptionRate")
    }
    
    func testBurnFuelCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 10, canChange: true))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 3, canChange: false))
            when(mock.setProperty(propertyName: "FuelReserve", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as! Int, 7)
            }
        }
        let adapter = FuelableAdapter(o: sut1)
        let cmd = BurnFuelCommand(f: adapter)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).getProperty(propertyName: "FuelReserve")
        verify(sut1).getProperty(propertyName: "FuelConsumptionRate")
        verify(sut1).setProperty(propertyName: "FuelReserve", propertyValue: any())
    }
    
    func testMoveFuelCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(5, 8))
            }
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 10, canChange: true))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 3, canChange: true))
            when(mock.setProperty(propertyName: "FuelReserve", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as! Int, 7)
            }
        }
        let cmd = MoveFuelCommand(m: MovableAdapter(o: sut1), f: FuelableAdapter(o: sut1))
        XCTAssertNoThrow(try cmd.execute())
    }
    
    func testFailMoveFuelCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(5, 8))
            }
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 2, canChange: true))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 3, canChange: true))
            when(mock.setProperty(propertyName: "FuelReserve", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as! Int, 7)
            }
        }
        let cmd = MoveFuelCommand(m: MovableAdapter(o: sut1), f: FuelableAdapter(o: sut1))
        XCTAssertThrowsError(try cmd.execute())
    }
    
    func testRotateVector() throws {
        let helper = (try! IoC.resolve("Helper") as Helper)
        XCTAssertEqual(helper.rotateVector(vector: simd_int2(-7, 0), angle: 90), simd_int2(0, 7))
        XCTAssertEqual(helper.rotateVector(vector: simd_int2(-7, 3), angle: -90), simd_int2(-3, -7))
        XCTAssertEqual(helper.rotateVector(vector: simd_int2(5, 5), angle: 180), simd_int2(-5, -5))
    }
    
    func testVectorLenght() throws {
        let helper = (try! IoC.resolve("Helper") as Helper)
        XCTAssertEqual(helper.vectorLenght(vector: simd_int2(3, 4)), 5)
        XCTAssertEqual(helper.vectorLenght(vector: simd_int2(5, 12)), 13)
    }
    
    func testChangeVelocityCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 0), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
            when(mock.setProperty(propertyName: "Velocity", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(0, 7))
            }
            when(mock.getProperty(propertyName: "Direction")).thenReturn((value: 0, canChange: true))
            when(mock.getProperty(propertyName: "AngularVelocity")).thenReturn((value: 90, canChange: true))
            when(mock.getProperty(propertyName: "MaxDirection")).thenReturn((value: 360, canChange: true))
            when(mock.setProperty(propertyName: "Direction", propertyValue: any())).thenDoNothing()
        }
        let cmd = ChangeVelocityCommand(m: MovableChangeVelocityAdapter(o: sut1), r: RotableAdapter(o: sut1))
        XCTAssertNoThrow(try cmd.execute())
    }
    
    func testRotateChangeVelocityCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Direction")).thenReturn((value: 180, canChange: true))
            when(mock.getProperty(propertyName: "AngularVelocity")).thenReturn((value: -90, canChange: true))
            when(mock.getProperty(propertyName: "MaxDirection")).thenReturn((value: 360, canChange: true))
            when(mock.setProperty(propertyName: "Direction", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? Int, 90)
                when(mock.getProperty(propertyName: "Direction")).thenReturn((value: propertyValue.value, canChange: true))
            }
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(0, -10), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).thenDoNothing()
            when(mock.setProperty(propertyName: "Velocity", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(10, 0))
            }
        }
        let cmd = RotateChangeVelocityCommand(m: MovableChangeVelocityAdapter(o: sut1), r: RotableAdapter(o: sut1))
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).setProperty(propertyName: "Direction", propertyValue: any())
        verify(sut1).setProperty(propertyName: "Velocity", propertyValue: any())
    }
    
    func testAdapterGenerator() throws {
        fillUObjectMove(sut: sut1)
        let adapter = try IoC.resolve("Adapter", Movable.self, sut1!) as Movable
        let cmd = MoveCommand(m: adapter)
        XCTAssertNoThrow(try cmd.execute())
    }

    func testCommandIoCGenerator() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(12, 5), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(-7, 3), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(5, 8))
            }
            when(mock.getProperty(propertyName: "FuelReserve")).thenReturn((value: 10, canChange: true))
            when(mock.getProperty(propertyName: "FuelConsumptionRate")).thenReturn((value: 3, canChange: true))
            when(mock.setProperty(propertyName: "FuelReserve", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as! Int, 7)
            }
        }
        let cmd: Command = try IoC.resolve("Command.MoveFuel", sut1!, sut1!)
        XCTAssertNoThrow(try cmd.execute())
        verify(sut1).setProperty(propertyName: "FuelReserve", propertyValue: any())
    }
    
    func testAdapterLambda() throws {
        class MoveCommandStartFinish: Command  {
            let m: MovableStartFinishAdapter
            init(m: MovableStartFinishAdapter) {
                self.m = m
            }
            func execute() throws {
                m.start()
                let position = try m.getPosition()
                let velocity = try m.getVelocity()
                guard position.canChange else {
                    throw ErrorList.commandException
                }
                let propertyValue = (value: position.value &+ velocity.value, canChange: position.canChange)
                try m.setPosition(position: propertyValue)
                m.finish()
            }
        }
        fillUObjectMove(sut: sut1)
        let adapter: MovableStartFinishAdapter = try IoC.resolve("Adapter", MovableStartFinish.self, sut1!)
        var cnt = 0
        adapter.setAdditionMethods([{
            print("Start moving")
            cnt += 1
        },{
            print("Finish moving")
            cnt += 1
        }])
        let cmd = MoveCommandStartFinish(m: adapter)
        XCTAssertNoThrow(try cmd.execute())
        XCTAssertEqual(cnt, 2)
    }
    
    func testDBConnection() throws {
        let db: DBConnection = try IoC.resolve("DB")
        var users = [[Any]]()
        do {
            _ = try db.write("DELETE FROM users WHERE username = ?? AND password = ??", "test", "test")
            _ = try db.write("INSERT INTO users  (username, password) VALUES (??,??), (??,??)", "test", "test", "test", "test")
            users = try db.read("SELECT * FROM users WHERE username = ?? AND password = ??", "test", "test")
            _ = try db.write("DELETE FROM users WHERE username = ?? AND password = ??", "test", "test")
        }
        XCTAssertEqual(users.count, 2)
    }
    
    func testUserManager() throws {
        let origUser = UserAPIModel(id: 1, username: "test", password: "test")
        let userManager: UserManager = try IoC.resolve("UserManager")
        _ = try userManager.register(username: origUser.username!, password: origUser.password!)
        guard let user = try userManager.get(id: Int(origUser.id!)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(origUser.username, user.username)
        XCTAssertEqual(origUser.password, user.password)
    }

    func testSetStartVelocityAndMove() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(5, 5), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(7, 5))
            }
            when(mock.setProperty(propertyName: "Velocity", propertyValue: any())).then {
                when(mock.getProperty(propertyName: "Velocity")).thenReturn($1)
            }
        }
        let cmd: Command = try IoC.resolve("Command.SetStartVelocityAndMove", sut1!, simd_int2(2, 0))
        try cmd.execute()
    }

    func testInterpretCommand() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(2, 2), canChange: true))
            when(mock.getProperty(propertyName: "Velocity")).thenReturn((value: simd_int2(0, 0), canChange: true))
            when(mock.setProperty(propertyName: "Position", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(7, 7))
            }
            when(mock.setProperty(propertyName: "Velocity", propertyValue: any())).then {
                _, propertyValue in
                XCTAssertEqual(propertyValue.value as? simd_int2, simd_int2(5, 5))
                when(mock.getProperty(propertyName: "Velocity")).thenReturn(propertyValue)
            }
        }
        let objectList = try! (IoC.resolve("Object.List") as ObjectList)
        objectList.append(sut1)
        try InterpretCommand(objectId: 0, commandId: 7, args: "{\"startVelocity\":[5,5]}").execute()
        verify(sut1).setProperty(propertyName: "Position", propertyValue: any())
        verify(sut1).setProperty(propertyName: "Velocity", propertyValue: any())
    }
    
    func fillStartCommand(start: @escaping () -> ()) -> Command {
        class MoveCommandStart: Command  {
            let m: MovableStartFinishAdapter
            init(m: MovableStartFinishAdapter) {
                self.m = m
            }
            func execute() throws {
                m.start()
            }
        }
        let adapter: MovableStartFinishAdapter = try! IoC.resolve("Adapter", MovableStartFinish.self, sut1!)
        adapter.setAdditionMethods([start, { }])
        return MoveCommandStart(m: adapter)
    }
    
    func fillThreadQueue(command: Command, count: Int) -> ThreadQueue {
        let commandQueue = Queue<Command>()
        let threadQueue = ThreadQueue()
        for _ in 0..<count {
            commandQueue.queue(command)
        }
        while !commandQueue.isEmpty() {
            threadQueue.add(command: commandQueue.dequeue()!)
        }
        return threadQueue
    }
    
    func testMultithreadStart() throws {
        var cnt = 0
        let ttlCnt = 1000
        let command = fillStartCommand(start: {
            cnt += 1
        })
        let threadQueue = fillThreadQueue(command: command, count: ttlCnt)
        XCTAssertEqual(threadQueue.queue.operationCount, ttlCnt)
        threadQueue.add(command: StartQueue())
        XCTAssertGreaterThan(threadQueue.queue.operationCount, 0)
        while cnt < ttlCnt {
        }
        XCTAssertLessThan(threadQueue.queue.operationCount, 10)
    }
    
    /*func testMultithreadHardStop() throws {
        var cnt = 0
        let ttlCnt = 1000
        let command = fillStartCommand(start: {
            cnt += 1
        })
        let threadQueue = fillThreadQueue(command: command, count: ttlCnt)
        threadQueue.add(command: StartQueue())
        while cnt < ttlCnt / 2 {
        }
        threadQueue.add(command: HardStopQueue())
        let eps = Int(Double(ttlCnt) * 0.3)
        XCTAssertLessThan(cnt, (ttlCnt / 2) + eps)
        XCTAssertGreaterThan(cnt, (ttlCnt / 2) - eps)
    }*/
    
    func testMultithreadSoftStop() throws {
        var cnt = 0
        let ttlCnt = 1000
        let command = fillStartCommand(start: {
            cnt += 1
        })
        let threadQueue = fillThreadQueue(command: command, count: ttlCnt)
        threadQueue.add(command: StartQueue())
        while cnt < ttlCnt {
            if cnt == ttlCnt / 2 {
                threadQueue.add(command: SoftStopQueue())
            }
        }
        XCTAssertLessThan(threadQueue.queue.operationCount, 10)
    }
    
    func testCollisionSameBlock() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(5, 6), canChange: true))
        }
        let adapter1 = MovableAdapter(o: sut1)
        stub(sut2) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(2, 1), canChange: true))
        }
        let adapter2 = MovableAdapter(o: sut2)
        let area10 = (try! IoC.resolve("Area.10") as Area)
        let area5 = (try! IoC.resolve("Area.5") as Area)
        try area10.updateTable(m: adapter1, objectId: 1)
        try area5.updateTable(m: adapter1, objectId: 1)
        try area10.updateTable(m: adapter2, objectId: 2)
        try area5.updateTable(m: adapter2, objectId: 2)
        XCTAssertEqual([2], try area10.getNearObjectIds(m: adapter1, objectId: 1))
        XCTAssertEqual([2], try area5.getNearObjectIds(m: adapter1, objectId: 1))
        XCTAssertEqual([1], try area10.getNearObjectIds(m: adapter2, objectId: 2))
        XCTAssertEqual([1], try area5.getNearObjectIds(m: adapter2, objectId: 2))
    }
    
    func testCollisionDifferentBlock() throws {
        stub(sut1) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(5, 6), canChange: true))
        }
        let adapter1 = MovableAdapter(o: sut1)
        stub(sut2) { mock in
            when(mock.getProperty(propertyName: "Position")).thenReturn((value: simd_int2(22, 15), canChange: true))
        }
        let adapter2 = MovableAdapter(o: sut2)
        let area10 = (try! IoC.resolve("Area.10") as Area)
        let area5 = (try! IoC.resolve("Area.5") as Area)
        try area10.updateTable(m: adapter1, objectId: 1)
        try area5.updateTable(m: adapter1, objectId: 1)
        try area10.updateTable(m: adapter2, objectId: 2)
        try area5.updateTable(m: adapter2, objectId: 2)
        XCTAssertEqual([], try area10.getNearObjectIds(m: adapter1, objectId: 1))
        XCTAssertEqual([], try area5.getNearObjectIds(m: adapter1, objectId: 1))
        XCTAssertEqual([], try area10.getNearObjectIds(m: adapter2, objectId: 2))
        XCTAssertEqual([], try area5.getNearObjectIds(m: adapter2, objectId: 2))
    }
}

