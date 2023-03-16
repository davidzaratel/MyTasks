//
//  NetworkMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import XCTest
@testable import TasksApp


final class NetworkTests: XCTestCase {

    var networkMock: NetworkMock = NetworkMock()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
//    func test_Network_fetchDataUsers_failure() async throws {
//        //Given
//        guard let url = Constants.listsURL else { throw errorMessages.urlTransformationError }
//        let lists = [ListItem(id: "82794284-DAF4-46A3-AE23-019C8CA217C8",
//                              title: "Telekom",
//                              tasks: [TaskItem(id: "039B05DB-A70A-4ED0-9475-B85646C0938D", title: "Hello")],
//                              color: ColorItem(id: "82794284-DAF4-46A3-AE23-019C8CA217C8",
//                              title: "ListColor4"))]
//        //When
//        let fetchedLists: [ListItem] = try await networkMock.fetchData(fromURL: url)
//        //Then
//        XCTAssertThrowsError(fetchedLists)
//    }

}
