//
//  RepositoriesTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
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
    
}
