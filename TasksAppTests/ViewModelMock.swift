//
//  ViewModelMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct ViewModelMock: ViewModelProtocol {
    var users: [User]
    
    var lists: [ListItem]
    
    var isLoading: Bool
    
    var listRepository: ListRepositoryProtocol
    
    var userRepository: UserRepositoryProtocol
    
    func getListsData() async {
        
    }
    
    func getUsersData() async {
        
    }
    
    func postNewUser(id: String, username: String, password: String) {
        
    }
    
    func addList(newListName: String, selectedColor: String) {
        
    }
    
    func deleteList(indexSet: IndexSet) {
        
    }
    
    func moveListOrder(indices: IndexSet, newOffset: Int) {
        
    }
    
    func addTasks(newTaskName: String, index: Int) {
        
    }
    
    func deleteTasks(indexSet: IndexSet, index: Int) {
        
    }
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int) {
        
    }
    
    
}
