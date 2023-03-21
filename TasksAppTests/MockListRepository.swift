//
//  ListRepositoryMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct MockListRepository: ListRepository {
    
    var mockNetwork: MockNetwork

        
    func getAllLists() async throws -> [ListItem] {
        guard let url = Constants.listsURL else { throw errorMessages.getDataRepositoryError }
        return try await mockNetwork.fetchData(fromURL: url)
    }
    
    func addList(newList: ListItem) {
        
    }
    
    func removeList(id: String) {
        
    }
    
    func updateTasks(updatedList: ListItem) {
        
    }
    
    func createListRequestBody(newListItem: ListItem) -> Data? {
        return nil
    }
}
