//
//  WebUserRepositoryTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
import Mockingbird
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
    
    func test_UsersRepository_getAllUsers_failure() async {
        //Given
        let userRepository = WebListRepository(network: MockNetwork(networkCase: .failure, returnType: .user))
        //When
        var users: [ListItem] = []
        do {
            users = try await userRepository.getAllLists()
        } catch {
            
        }
        //Then
        XCTAssertEqual(users, [])
    }
    
    func test_UsersRepositoryMockingbird_getAllUsers_success() async {
        //Given
        guard let url = Constants.usersURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(MockData.usersData)
        
        let userRepository = WebUserRepository(network: mockingbirdNetwork)
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {

        }
        //Then
        XCTAssertEqual(users, MockData.usersData)
    }
    
    func test_UsersRepositoryMockingbird_getAllUsers_failure() async {
        //Given
        guard let url = Constants.usersURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        let emptyArray: [User] = []
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(emptyArray)
        
        let userRepository = WebUserRepository(network: mockingbirdNetwork)
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {

        }
        //Then
        XCTAssertEqual(users, [])
    }

}
