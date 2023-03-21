//
//  UsersRepositoryMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct MockUsersRepository: UserRepository {
        
    func getAllUsers() async throws -> [User] {
        return []
    }
    
    func addUser(newUser: User) {
        
    }
    
    func createUserRequestBody(newUser: User) -> Data? {
        return nil
    }
}
