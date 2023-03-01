//
//  ViewModel.swift
//  TasksApp
//
//  Created by David Zárate López on 27/02/23.
//

import Foundation
import SwiftUI

struct ListItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
    var tasks: [TaskItem]
    var color: ColorItem
}

struct TaskItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
}

struct ColorItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
}

struct User: Hashable, Codable, Identifiable  {
    var id: String
    var username: String
    var password: String
}

///View Model of the Class, contains the lists of Tasks of the User
class ViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var lists: [ListItem] = []
    @Published private(set) var isLoading = false
    @Published var network: Network = Network()
    
    init(){
        getLists()
//        getUsers()
    }
    
    func getLists() {
        isLoading = true
        
        network.fetchData(fromURL: "http://localhost:3000/lists") { returnedData in
            if let data = returnedData {
                guard let fetchedLists = try? JSONDecoder().decode([ListItem].self, from: data) else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.lists = fetchedLists
                    self?.isLoading = false
                }
            } else {
                print("The data couldn't be fetched")
            }
        }
    }
    
    func getUsers(){
        let newUser = User(id: "2", username: "Aleks", password: "goodbye")
        network.postUsers(fromURL: "http://localhost:3000/users", newUser: newUser)
        network.fetchData(fromURL: "http://localhost:3000/users") { returnedData in
            if let data = returnedData {
                guard let fetchedUsers = try? JSONDecoder().decode([User].self, from: data) else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.users = fetchedUsers
                }
            } else {
                print("The data couldn't be fetched")
            }
        }
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString, title: newListName, tasks: [], color: ColorItem(id: UUID().uuidString, title: selectedColor))
        network.postNewList(fromURL: "http://localhost:3000/lists", newListItem: newList)
        self.lists.append(newList)
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
