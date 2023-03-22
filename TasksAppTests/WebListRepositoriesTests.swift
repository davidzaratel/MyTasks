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
            
        }
        //Then
        XCTAssertEqual(lists, networkMock.listData)
    }
    
    func test_ListRepository_getAllLists_failure() async {
        //Given
        let listRepository = WebListRepository(network: MockNetwork(networkCase: .failure, returnType: .list))
        //When
        var lists: [ListItem] = []
        do {
            lists = try await listRepository.getAllLists()
        } catch {
            
        }
        //Then
        XCTAssertEqual(lists, [])
    }
    
    func test_UsersRepositoryMockingbird_getAllLists_success() async {
        //Given
        guard let url = Constants.listsURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(MockData.listData)
        
        let userRepository = WebListRepository(network: mockingbirdNetwork)
        //When
        var lists: [ListItem] = []
        do {
            lists = try await userRepository.getAllLists()
        } catch {

        }
        //Then
        XCTAssertEqual(lists, MockData.listData)
    }
    
    func test_UsersRepositoryMockingbird_getAllLists_failure() async {
        //Given
        guard let url = Constants.listsURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        let emptyArray: [ListItem] = []
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(emptyArray)
        
        let listRepository = WebListRepository(network: mockingbirdNetwork)
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
