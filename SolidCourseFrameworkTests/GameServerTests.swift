//
//  ServerTests.swift
//  SolidCourseFrameworkTests
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation
import XCTVapor
@testable import SolidCourseFramework

final class MyTests: XCTestCase {
    func testRealServer() throws {
        let server = try GameServer()
        try server.run()
        while true {}
    }
}
