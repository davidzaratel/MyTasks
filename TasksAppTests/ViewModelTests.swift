//
//  ViewModelTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 21.03.23.
//

import XCTest
import Mockingbird
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
        XCTAssertEqual(viewModel.lists, MockData.listData)
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
        XCTAssertEqual(viewModel.users, MockData.usersData)
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
    
    
    func test_ViewModelMockingbird_getListsData_Success() async {
        //Given
        let mockWebListRepository = mock(ListRepository.self)
        await given(mockWebListRepository.getAllLists()).willReturn(MockData.listData)
        let mockWebUserRepository = mock(UserRepository.self)
        let viewModel = ViewModel(listRepository: mockWebListRepository,
                                  userRepository: mockWebUserRepository
        )
        //When
        await viewModel.getListsData()
        
        //Then
        XCTAssertEqual(viewModel.lists, MockData.listData)
    }
    
    func test_ViewModelMockingbird_getListsData_failure() async {
        //Given
        let mockWebListRepository = mock(ListRepository.self)
        await given(mockWebListRepository.getAllLists()).willReturn([])
        let mockWebUserRepository = mock(UserRepository.self)
        let viewModel = ViewModel(listRepository: mockWebListRepository,
                                  userRepository: mockWebUserRepository
        )
        //When
        await viewModel.getListsData()
        
        //Then
        XCTAssertEqual(viewModel.lists, [])
    }
    
    
    func test_ViewModelMockingbird_getUsersData_Success() async {
        //Given
        let mockWebListRepository = mock(ListRepository.self)
        let mockWebUserRepository = mock(UserRepository.self)
        await given(mockWebUserRepository.getAllUsers()).willReturn(MockData.usersData)
        let viewModel = ViewModel(listRepository: mockWebListRepository,
                                  userRepository: mockWebUserRepository
        )
        //When
        await viewModel.getUsersData()
        
        //Then
        XCTAssertEqual(viewModel.users, MockData.usersData)
    }
    
    
    func test_ViewModelMockingbird_getUsersData_failure() async {
        //Given
        let mockWebListRepository = mock(ListRepository.self)
        let mockWebUserRepository = mock(UserRepository.self)
        await given(mockWebUserRepository.getAllUsers()).willReturn([])
        let viewModel = ViewModel(listRepository: mockWebListRepository,
                                  userRepository: mockWebUserRepository
        )
        //When
        await viewModel.getUsersData()
        
        //Then
        XCTAssertEqual(viewModel.users, [])
    }
    
    
}
