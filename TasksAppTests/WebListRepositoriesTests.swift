//
//  RepositoriesTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
import Mockingbird
@testable import TasksApp

final class RepositoriesTests: XCTestCase {

    var networkMock = MockNetwork()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

  
    func test_ListRepository_getAllLists_success() async {
        //Given
        let listRepository = WebListRepository(network: MockNetwork(networkCase: .success, returnType: .list))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            return XCTFail("Weren't able to get all lists")
        }
        //Then
        XCTAssertEqual(lists, MockData.listData)
    }
    
    func test_ListRepository_getAllLists_failure() async {
        //Given
        var thrownError: Error?
        let listRepository = WebListRepository(network: MockNetwork(networkCase: .failure, returnType: .list))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            thrownError = error
        }
        //Then
        XCTAssertEqual(lists, [])
        XCTAssertNotNil(thrownError)
    }
    
    func test_UsersRepositoryMockingbird_getAllLists_success() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        await given(mockNetwork.fetchData(fromURL: Constants.listsURL!))
            .willReturn(MockData.listData)
        
        let userRepository = WebListRepository(network: mockNetwork)
        //When
        var lists: [ListItem] = []
        do {
            lists = try await userRepository.getAllLists()
        } catch {
            return XCTFail("Weren't able to get all lists")
        }
        //Then
        XCTAssertEqual(lists, MockData.listData)
    }
    
    func test_UsersRepositoryMockingbird_getAllLists_failure() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        let emptyArray: [ListItem] = []
        await given(mockNetwork.fetchData(fromURL: Constants.listsURL!))
            .willReturn(emptyArray)
        
        let listRepository = WebListRepository(network: mockNetwork)
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            return XCTFail("Weren't able to get all lists")
        }
        //Then
        XCTAssertEqual(lists, [])
    }
    
}
