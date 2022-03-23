//
//  User.swift
//  SolidCourseFramework
//
//  Created by руслан карымов on 25.02.2022.
//

import Foundation

class UserManager {
    
    let db: DBConnection
    
    init() throws {
        db = try IoC.resolve("DB") as DBConnection
    }
    
    func get(id: Int) throws -> UserAPIModel? {
        do {
            let user = try db.read("SELECT * FROM users WHERE id = ??", String(id))
            if user.count == 1 && user[0].count == 3 {
                return try IoC.resolve("APIModel.UserAPIModel", user[0][0], user[0][1], user[0][2]) as UserAPIModel
            }
        }
        return nil
    }
    
    func get(username: String) throws -> UserAPIModel? {
        do {
            let user = try db.read("SELECT * FROM users WHERE username = ??", username)
            if user.count == 1 && user[0].count == 3 {
                return try IoC.resolve("APIModel.UserAPIModel", user[0][0], user[0][1], user[0][2]) as UserAPIModel
            }
        }
        return nil
    }
    
    func delete(id: Int) throws {
        do {
            _ = try db.write("DELETE FROM users WHERE id = ??", String(id))
        }
    }
    
    func register(username: String, password: String) throws -> UserAPIModel? {
        do {
            let userId = try db.write("INSERT INTO users  (username, password) VALUES (??,??)", username, password)
            return try IoC.resolve("APIModel.UserAPIModel", userId, username, password) as UserAPIModel
        } catch {
            return nil
        }
    }
}
