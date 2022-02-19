//
//  ServerTests.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 19.02.2022.
//

import Foundation
import XCTVapor
@testable import SolidCourseFramework

final class ServerTests: XCTestCase {
    func testHelloWorld() throws {
        //try TankServer.start()
        let appGet = Application(.testing)
        defer { appGet.shutdown() }
        appGet.get("hello") { req -> String in
            return "Hello, world!"
        }
        try appGet.test(.GET, "hello", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
        //TankServer.stop()
    }
}
