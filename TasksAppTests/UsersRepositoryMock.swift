//
//  UsersRepositoryMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct UsersRepositoryMock: UserRepositoryProtocol{
    var network: TasksApp.NetworkProtocol
    
    func getAllUsers() async throws -> [User] {
        return []
    }
    
    func postUser(newUser: User) {
        
    }
    
    func createUserRequestBody(newUser: User) -> Data? {
        return nil
    }
    
    
}
