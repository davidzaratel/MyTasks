//
//  NetworkTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
import Mockingbird
@testable import TasksApp

final class NetworkTests: XCTestCase {
    
    var networkMock = MockNetwork()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    
    func test_NetworkMock_fetchListData_success() async {
        //Given
        networkMock.networkCase = NetworkCases.success
        networkMock.returnType = .list
        //When
        var fetchedData: [ListItem] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: Constants.listsURL!)
        } catch {
            return XCTFail("Weren't able to fetch data")
        }
        //Then
        XCTAssertEqual(MockData.listData, fetchedData)
    }
    
    func test_NetworkMock_fetchListData_failure() async {
        //Given
        var thrownError: Error?
        networkMock.networkCase = NetworkCases.failure
        //When
        var fetchedData: [ListItem] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: Constants.listsURL!)
        } catch {
            thrownError = error
        }
        //Then
        XCTAssertEqual(fetchedData, [])
        XCTAssertNotNil(thrownError)
    }
    
    func test_NetworkMock_fetchUserData_success() async {
        //Given
        networkMock.networkCase = NetworkCases.success
        networkMock.returnType = .user
        //When
        var fetchedData: [User] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: Constants.usersURL!)
        } catch {
            return XCTFail("Weren't able to fetch data")
        }
        //Then
        XCTAssertEqual(MockData.usersData, fetchedData)
    }
    
    func test_NetworkMock_fetchUserData_failure() async {
        //Given
        var thrownError: Error?
        networkMock.networkCase = NetworkCases.failure
        //When
        var fetchedData: [User] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: Constants.usersURL!)
        } catch {
            thrownError = error
        }
        //Then
        XCTAssertEqual(fetchedData, [])
        XCTAssertNotNil(thrownError)
    }
    
    func test_NetworkMockingbird_fetchListData_success() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        var fetchedData: [ListItem] = []
        await given(mockNetwork.fetchData(fromURL: Constants.listsURL!))
            .willReturn(MockData.listData)
        
        //When
        do {
            fetchedData = try await mockNetwork
                .fetchData(fromURL: Constants.listsURL!)
        } catch {
            return XCTFail("Weren't able to fetch data")
        }
        
        //Then
        XCTAssertEqual(fetchedData, MockData.listData)
    }
    
    func test_NetworkMockingbird_fetchUserData_success() async {
        //Given
        let mockNetwork = mock(NetworkProtocol.self)
        var fetchedData: [User] = []
        await given(mockNetwork.fetchData(fromURL: Constants.usersURL!))
            .willReturn(MockData.usersData)

        //When
        do {
            fetchedData = try await mockNetwork
                .fetchData(fromURL: Constants.usersURL!)
        } catch {
            return XCTFail("Weren't able to fetch data")
        }
        
        //Then
        XCTAssertEqual(fetchedData, MockData.usersData)
    }

}
