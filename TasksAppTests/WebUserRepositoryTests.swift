//
//  WebUserRepositoryTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
@testable import TasksApp

final class WebUserRepositoryTests: XCTestCase {

    var networkMock = MockNetwork()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_UsersRepository_getAllUsers_success() async {
        //Given
        let userRepository = WebUserRepository(network: MockNetwork(networkCase: .success, returnType: .user))
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {
            
        }
        //Then
        XCTAssertEqual(users, networkMock.usersData)
    }
    
    func test_UsersRepository_getAllUserss_failure() async {
        //Given
        let listRepository = WebListRepository(network: MockNetwork(networkCase: .failure, returnType: .user))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            
        }
        //Then
        XCTAssertEqual(lists, [])
    }

}
