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
    @Published var repository: Repository = Repository()
    
    @MainActor
    func getData(urlString: String) async {
        guard let url = URL(string: urlString) else { return }
        isLoading = true
        Task {
            do {
                if urlString == Constants.usersURL {
                    users = try await repository.fetchData(fromURL: url)
                } else {
                    lists = try await repository.fetchData(fromURL: url)
                }
                isLoading = false
            } catch {
                print("Error", error)
            }
        }
    }
    
    func postNewUser(id: String, username: String, password: String) {
        let newUser = User(id: id, username: username, password: password)
        guard let url = URL(string: Constants.usersURL) else { return }
        repository.makeUserRequest(fromURL: url, method:"POST", newUser: newUser)
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString,
                               title: newListName,
                               tasks: [],
                               color: ColorItem(
                                id: UUID().uuidString,
                                title: selectedColor)
                                )
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
        guard let url = URL(string: Constants.getParamURL(url: Constants.listsURL, params: self.lists[index].id)) else { return }
        repository.makeListRequest(fromURL: url, method: "PUT", newListItem: self.lists[index])
    }
    
    func deleteTasks(indexSet: IndexSet, index: Int){
        self.lists[index].tasks.remove(atOffsets: indexSet)
        guard let url = URL(string: Constants.getParamURL(url: Constants.listsURL, params: self.lists[index].id)) else { return }
        repository.makeListRequest(fromURL: url, method: "PUT", newListItem: self.lists[index])
    }
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int){
        self.lists[index].tasks.move(fromOffsets: indices, toOffset: newOffset)
        guard let url = URL(string: Constants.getParamURL(url: Constants.listsURL, params: self.lists[index].id)) else { return }
        repository.makeListRequest(fromURL: url, method: "PUT", newListItem: self.lists[index])
    }
}
