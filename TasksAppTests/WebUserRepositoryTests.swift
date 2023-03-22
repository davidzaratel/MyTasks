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
            return XCTFail("Weren't able to get all users")
        }
        //Then
        XCTAssertEqual(users, MockData.usersData)
    }
    
    func test_UsersRepository_getAllUsers_failure() async {
        //Given
        var thrownError: Error?
        let userRepository = WebUserRepository(network: MockNetwork(networkCase: .failure, returnType: .user))
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {
            thrownError = error
        }
        
        //Then
        XCTAssertEqual(users, [])
        XCTAssertNotNil(thrownError)
    }
    
    func test_UsersRepositoryMockingbird_getAllUsers_success() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        await given(mockNetwork.fetchData(fromURL: Constants.usersURL!)).willReturn(MockData.usersData)
        
        let userRepository = WebUserRepository(network: mockNetwork)
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {
            return XCTFail("Weren't able to get all users")
        }
        //Then
        XCTAssertEqual(users, MockData.usersData)
    }
    
    func test_UsersRepositoryMockingbird_getAllUsers_failure() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        let emptyArray: [User] = []
        await given(mockNetwork.fetchData(fromURL: Constants.usersURL!))
            .willReturn(emptyArray)
        
        let userRepository = WebUserRepository(network: mockNetwork)
        //When
        var users: [User] = []
        do {
            users = try await userRepository.getAllUsers()
        } catch {
            return XCTFail("Weren't able to get all users")
        }
        //Then
        XCTAssertEqual(users, [])
    }

}
