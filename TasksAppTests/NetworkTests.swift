//
//  NetworkTests.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 20.03.23.
//

import XCTest
@testable import TasksApp

final class NetworkTests: XCTestCase {
    
    var networkMock = NetworkMock()

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
        XCTAssertEqual(networkMock.listData, fetchedData)
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
        XCTAssertEqual(networkMock.usersData, fetchedData)
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
    }


}
