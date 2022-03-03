//
//  DB.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 21.02.2022.
//

import Foundation
import SQLite3

protocol DBConnection {
    func read(_ args: String...) throws -> [[Any]]
    func write(_ args: String...) throws -> Int
}

extension String {
    public func replaceFirst(of pattern: String, with replacement: String) -> String {
        if let range = self.range(of: pattern){
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
    }
}

class DB: DBConnection {
    var db: OpaquePointer?
    let valueMask = "??"
    
    init(dbFile: String) throws {
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
    
    func read(_ args: String...) throws -> [[Any]] {
        guard !args.isEmpty else {
            return []
        }
        var queryString = args[0]
        if args.count > 1 {
            for i in 1..<args.count {
                queryString = queryString.replaceFirst(of: valueMask, with: escape(args[i]))
            }
        }
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
    
    func write(_ args: String...) throws -> Int {
        guard !args.isEmpty else {
            throw ErrorList.dbError
        }
        var queryString = args[0]
        if args.count > 1 {
            for i in 1..<args.count {
                queryString = queryString.replaceFirst(of: valueMask, with: escape(args[i]))
            }
        }
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
        let result = Int(sqlite3_last_insert_rowid(query))
        return result
    }
    
    func escape(_ string: String) -> String {
        var out = "'"
        for c in string.unicodeScalars {
            switch c {
            case "\0":
                out += "\\0"
            case "\n":
                out += "\\n"
            case "\r":
                out += "\\r"
            case "\u{8}":
                out += "\\b"
            case "\t":
                out += "\\t"
            case "\\":
                out += "\\\\"
            case "'":
                out += "\\'"
            case "\"":
                out += "\\\""
            case "\u{1A}":
                out += "\\Z"
            default:
                out.append(Character(c))
            }
        }
        out.append("'")
        return out
    }
}
