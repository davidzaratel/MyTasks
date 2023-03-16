//
//  Protocols.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation


protocol UserRepository {
    
    func getAllUsers() async throws -> [User]
    
    func addUser(newUser: User)
    
}

protocol ListRepository {
    
    func getAllLists() async throws -> [ListItem]
    
    func addList(newList: ListItem)
        
    func removeList(id: String)
    
    func updateTasks(updatedList: ListItem)
    
}


protocol NetworkProtocol {
    
    func fetchData<T:Codable> (fromURL url: URL) async throws -> T
    
    func executeRequest(request: URLRequest)
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data?)
    
}

protocol ViewModelProtocol {
    
    var users: [User] { get }
    var lists: [ListItem] { get }
    var isLoading: Bool { get }
    var listRepository: ListRepository { get }
    var userRepository: UserRepository { get }
    
    @MainActor
    func getListsData() async
    @MainActor
    func getUsersData() async
    
    func postNewUser(id: String, username: String, password: String)
    
    func addList(newListName: String, selectedColor: String)
    
    func deleteList(indexSet: IndexSet)
    
    func moveListOrder(indices: IndexSet, newOffset: Int)
    
    func addTasks(newTaskName: String, index: Int)
    
    func deleteTasks(indexSet: IndexSet, index: Int)
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int)
}
