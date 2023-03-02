//
//  ViewModel.swift
//  TasksApp
//
//  Created by David Zárate López on 27/02/23.
//

import Foundation
import SwiftUI

///View Model of the Class, contains the lists of Tasks of the User
class ViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var lists: [ListItem] = []
    @Published private(set) var isLoading = false
    @Published var network: Network = Network()
    @Published var repository: Repository = Repository()
    
    init(){
//        getLists()
        getUsers()
    }
    
    func getLists(){
//        repository.getData(fromURL: Constants.listsURL)
    }
    
    func getUsers(){
        repository.getUsers(fromURL: Constants.usersURL)
    }
    
    func postNewUser(id: String, username: String, password: String) {
        let newUser = User(id: id, username: username, password: password)
//        network.postUsers(fromURL: "http://localhost:3000/users", newUser: newUser)
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString, title: newListName, tasks: [], color: ColorItem(id: UUID().uuidString, title: selectedColor))
//        network.postNewList(fromURL: "http://localhost:3000/lists", newListItem: newList)
        self.lists.append(newList)
    }
    
    func deleteList(indexSet: IndexSet) {
        self.lists.remove(atOffsets: indexSet)
    }
    
    func moveListOrder(indices: IndexSet, newOffset: Int){
        self.lists.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func addTasks(newTaskName: String, index: Int){
        let newTask = TaskItem(id: UUID().uuidString, title: newTaskName)
        self.lists[index].tasks.append(newTask)
    }
    
    func deleteTasks(indexSet: IndexSet, index: Int){
        self.lists[index].tasks.remove(atOffsets: indexSet)
    }
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int){
        self.lists[index].tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
}
