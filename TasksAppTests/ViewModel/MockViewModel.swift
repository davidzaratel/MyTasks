//
//  ViewModelMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct MockViewModel: ViewModelProtocol {
    var users: [TasksApp.User]
    
    var lists: [TasksApp.ListItem]
    
    var isLoading: Bool
    
    var listRepository: ListRepository
    
    var userRepository: UserRepository
    
    func getListsData() async {
        
    }
    
    func getUsersData() async {
        
    }
    
    func createUser(id: String, username: String, password: String) {
        
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
