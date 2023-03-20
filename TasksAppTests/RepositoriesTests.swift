//
//  RepositoriesTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
@testable import TasksApp

final class RepositoriesTests: XCTestCase {

    var networkMock = NetworkMock()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

  
    func test_ListRepository_getAllLists_success() async {
        //Given
        let listRepository = ListRepository(network: NetworkMock(networkCase: .success, returnType: .list))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            
        }
        //Then
        XCTAssertEqual(lists, networkMock.listData)
    }
    
    func test_ListRepository_getAllLists_failure() async {
        //Given
        let listRepository = ListRepository(network: NetworkMock(networkCase: .failure, returnType: .list))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            
        }
        //Then
        XCTAssertEqual(lists, [])
    }
    
    func test_UsersRepository_getAllUsers_success() async {
        //Given
        let userRepository = UserRepository(network: NetworkMock(networkCase: .success, returnType: .user))
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
        let listRepository = ListRepository(network: NetworkMock(networkCase: .failure, returnType: .user))
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
