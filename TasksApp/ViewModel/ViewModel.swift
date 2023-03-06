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
        getLists()
//        getUsers()
    }
    
    func getLists() {
        isLoading = true
        guard let url = URL(string: Constants.listsURL) else { return }
            network.fetchData(fromURL: url) { returnedData in
                if let data = returnedData {
                    guard let fetchedData = try? JSONDecoder().decode([ListItem].self, from: data) else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        print("This is the fetched data", fetchedData)
                        self?.isLoading = false
                        self?.lists = fetchedData
                    }
                } else {
                    print("The data couldn't be fetched")
                }
            }
    }
    

    func getUsers() {
        isLoading = true
        guard let url = URL(string: Constants.usersURL) else { return }
            network.fetchData(fromURL: url) { returnedData in
                if let data = returnedData {
                    guard let fetchedData = try? JSONDecoder().decode([User].self, from: data) else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        print("This is the fetched data", fetchedData)
                        self?.isLoading = false
                        self?.users = fetchedData
                    }
                } else {
                    print("The data couldn't be fetched")
                }
            }
    }
    
    func postNewUser(id: String, username: String, password: String) {
        let newUser = User(id: id, username: username, password: password)
        guard let url = URL(string: Constants.usersURL) else { return }
        repository.postNewUser(fromURL: url, newUser: newUser)
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString, title: newListName, tasks: [], color: ColorItem(id: UUID().uuidString, title: selectedColor))
        guard let url = URL(string: Constants.listsURL) else { return }
        repository.makeListRequest(fromURL: url, method: "POST", newListItem: newList)
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
        let paramURL = Constants.listsURL + "/" + self.lists[index].id
        guard let url = URL(string: paramURL) else { return }
        repository.makeListRequest(fromURL: url, method: "PUT", newListItem: self.lists[index])
    }
    
    func deleteTasks(indexSet: IndexSet, index: Int){
        self.lists[index].tasks.remove(atOffsets: indexSet)
        let paramURL = Constants.listsURL + "/" + self.lists[index].id
        guard let url = URL(string: paramURL) else { return }
        repository.makeListRequest(fromURL: url, method: "PUT", newListItem: self.lists[index])
    }
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int){
        self.lists[index].tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func toggleIsLoading() {
        self.isLoading.toggle()
    }
    
}
