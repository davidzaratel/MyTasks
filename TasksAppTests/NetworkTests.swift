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
        guard let url = Constants.listsURL else { return }
        //When
        var fetchedData: [ListItem] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: url)
        } catch {
            
        }
        //Then
        XCTAssertEqual(MockData.listData, fetchedData)
        XCTAssertEqual(url, Constants.listsURL)
    }
    
    func test_NetworkMock_fetchListData_failure() async {
        //Given
        networkMock.networkCase = NetworkCases.failure
        guard let url = Constants.listsURL else { return }
        //When
        var fetchedData: [ListItem] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: url)
        } catch {
            
        }
        //Then
        XCTAssertEqual(fetchedData, [])
        XCTAssertEqual(url, Constants.listsURL)
    }
    
    func test_NetworkMock_fetchUserData_success() async {
        //Given
        networkMock.networkCase = NetworkCases.success
        networkMock.returnType = .user
        guard let url = Constants.usersURL else { return }
        //When
        var fetchedData: [User] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: url)
        } catch {
            
        }
        //Then
        XCTAssertEqual(MockData.usersData, fetchedData)
        XCTAssertEqual(url, Constants.usersURL)
    }
    
    func test_NetworkMock_fetchUserData_failure() async {
        //Given
        networkMock.networkCase = NetworkCases.failure
        guard let url = Constants.usersURL else { return }
        //When
        var fetchedData: [User] = []
        
        do {
            fetchedData = try await networkMock.fetchData(fromURL: url)
        } catch {
            
        }
        //Then
        XCTAssertEqual(fetchedData, [])
        XCTAssertEqual(url, Constants.usersURL)
    }
    
    func test_NetworkMockingbird_fetchListData_success() async {
        guard let url = Constants.listsURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        var fetchedData: [ListItem] = []
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(MockData.listData)
        do {
            fetchedData = try await mockingbirdNetwork.fetchData(fromURL: url)
        } catch {

        }
        
        XCTAssertEqual(fetchedData, MockData.listData)
        XCTAssertEqual(url, Constants.listsURL)
    }
    
    func test_NetworkMockingbird_fetchUserData_success() async {
        //Given
        guard let url = Constants.usersURL else { return }
        let mockingbirdNetwork = mock(NetworkProtocol.self)
        var fetchedData: [User] = []
        await given(mockingbirdNetwork.fetchData(fromURL: url)).willReturn(MockData.usersData)

        //When
        do {
            fetchedData = try await mockingbirdNetwork.fetchData(fromURL: url)
        } catch {

        }
        
        //Then
        XCTAssertEqual(fetchedData, MockData.usersData)
        XCTAssertEqual(url, Constants.usersURL)
    }

}
