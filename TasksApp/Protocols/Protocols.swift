//
//  Protocols.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation


protocol UserRepositoryProtocol {
    
    var network: Network { get }
    
    func getAllUsers() async throws -> [User]
    
    func postUser(newUser: User)
    
    func createUserRequestBody(newUser: User) -> Data?
}

protocol ListRepositoryProtocol {
    var network: Network { get }
    
    func getAllLists() async throws -> [ListItem]
    
    func addList(newList: ListItem)
        
    func removeList(id: String)
    
    func updateTasks(updatedList: ListItem)
    
    func createListRequestBody(newListItem: ListItem) -> Data?
}


protocol NetworkProtocol {
    func fetchData<T:Codable> (fromURL url: URL) async throws -> T
    
    func executeRequest(request: URLRequest)
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data?)
}

protocol ViewModelProtocol: ObservableObject {
    
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
