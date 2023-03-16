//
//  ListRepositoryMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct ListRepositoryMock: ListRepositoryProtocol {
    var network: TasksApp.NetworkProtocol
    
    func getAllLists() async throws -> [ListItem] {
        return []
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
