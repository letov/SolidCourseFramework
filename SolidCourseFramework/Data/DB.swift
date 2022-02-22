//
//  DB.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 21.02.2022.
//

import Foundation
import SQLite3

class DB {
    var db: OpaquePointer?
    
    init() throws {
        guard let dbFile = Bundle(for: type(of: self)).path(forResource: "db", ofType: "sqlite")else {
            throw ErrorList.dbError
        }
        var db: OpaquePointer?
        if sqlite3_open_v2(dbFile, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK && db != nil {
            self.db = db
        } else {
            throw ErrorList.dbError
        }
    }
    
    func getColumnValue(index: Int32, colType: String, query: OpaquePointer) -> Any? {
        switch colType {
        case "INTEGER":
            let val = sqlite3_column_int(query, index)
            return Int(val)
        case "FLOAT":
            let val = sqlite3_column_double(query, index)
            return Double(val)
        case "BLOB":
            let data = sqlite3_column_blob(query, index)
            let size = sqlite3_column_bytes(query, index)
            let val = NSData(bytes:data, length: Int(size))
            return val
        case "TEXT":
            guard let buffer = UnsafePointer<UInt8>(sqlite3_column_text(query, index)) else {
                return nil
            }
            let val = String(cString: buffer)
            return val
        default:
            return nil
        }
    }
    
    func read(_ queryString: String) throws -> [[Any]] {
        var query: OpaquePointer? = nil
        defer {
            sqlite3_finalize(query)
        }
        var result = [[Any]]()
        if sqlite3_prepare_v2(db, queryString, -1, &query, nil) == SQLITE_OK {
            guard let query = query else {
                throw ErrorList.dbError
            }
            let colCount = sqlite3_column_count(query)
            var colTypes = [String]()
            for i in 0..<colCount {
                colTypes.append(String(cString: sqlite3_column_decltype(query, Int32(i))))
            }
            while sqlite3_step(query) == SQLITE_ROW {
                var row = [Any]()
                for (i, colType) in colTypes.enumerated() {
                    guard let value = getColumnValue(index: Int32(i), colType: colType, query: query) else {
                        throw ErrorList.dbError
                    }
                    row.append(value)
                }
                result.append(row)
            }
        } else {
            throw ErrorList.dbError
        }
        return result
    }
    
    func write(_ queryString: String) throws {
        var query: OpaquePointer? = nil
        defer {
            sqlite3_finalize(query)
        }
        guard sqlite3_prepare_v2(db, queryString, -1, &query, nil) == SQLITE_OK else {
            throw ErrorList.dbError
        }
        guard sqlite3_step(query) == SQLITE_DONE else {
            throw ErrorList.dbError
        }
    }
}
