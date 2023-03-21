//
//  ViewModelTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 21.03.23.
//

import XCTest
@testable import TasksApp

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    func test_ViewModel_getListsData_Success() async {
        //Given
        let viewModel = ViewModel(listRepository:
                                    WebListRepository(network: MockNetwork(networkCase: .success, returnType: .list)),
                                  userRepository:
                                    WebUserRepository(network: MockNetwork(networkCase: .success, returnType: .user))
        )
        //When
        await viewModel.getListsData()
        
        //Then
        XCTAssertEqual(viewModel.lists, MockNetwork().listData)
    }
    
    func test_ViewModel_getListsData_failure() async {
        //Given
        let viewModel = ViewModel(listRepository:
                                    WebListRepository(network: MockNetwork(networkCase: .failure, returnType: .list)),
                                  userRepository:
                                    WebUserRepository(network: MockNetwork(networkCase: .success, returnType: .user))
        )
        //When
        await viewModel.getListsData()
        
        //Then
        XCTAssertEqual(viewModel.lists, [])
    }
    
    func test_ViewModel_getUsersData_Success() async {
        //Given
        let viewModel = ViewModel(listRepository:
                                    WebListRepository(network: MockNetwork(networkCase: .success, returnType: .list)),
                                  userRepository:
                                    WebUserRepository(network: MockNetwork(networkCase: .success, returnType: .user))
        )
        //When
        await viewModel.getUsersData()
        
        //Then
        XCTAssertEqual(viewModel.users, MockNetwork().usersData)
    }
    
    func test_ViewModel_getUsersData_failure() async {
        //Given
        let viewModel = ViewModel(listRepository:
                                    WebListRepository(network: MockNetwork(networkCase: .success, returnType: .list)),
                                  userRepository:
                                    WebUserRepository(network: MockNetwork(networkCase: .failure, returnType: .user))
        )
        //When
        await viewModel.getUsersData()
        
        //Then
        XCTAssertEqual(viewModel.users, [])
    }
    
}
