//
//  ViewModel.swift
//  TasksApp
//
//  Created by David Zárate López on 27/02/23.
//

import Foundation
import SwiftUI

///View Model of the Class, contains the lists of Tasks of the User
class ViewModel: ViewModelProtocol, ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var lists: [ListItem] = []
    @Published private(set) var isLoading: Bool = false
    private(set) var listRepository: ListRepository
    private(set) var userRepository: UserRepository
    
    init(listRepository: ListRepository,
         userRepository: UserRepository) {
        self.listRepository = listRepository
        self.userRepository = userRepository
    }
    
    @MainActor
    func getListsData() async {
        isLoading = true
        do {
            self.lists = try await listRepository.getAllLists()
            isLoading = false
        } catch {
            print("Error", error)
            isLoading = false
        }
    }
    
    @MainActor
    func getUsersData() async {
        isLoading = true
        do {
            self.users = try await userRepository.getAllUsers()
            isLoading = false
        } catch {
            print("Error", error)
            isLoading = false
        }
    }
    
    
    func createUser(id: String, username: String, password: String) {
        let newUser = User(id: id, username: username, password: password)
        users.append(newUser)
        userRepository.addUser(newUser: newUser)
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString,
                               title: newListName,
                               tasks: [],
                               color: ColorItem(
                                id: UUID().uuidString,
                                title: selectedColor)
                                )
        listRepository.addList(newList: newList)
        self.lists.append(newList)
    }
    
    func deleteList(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        if index < lists.count && index >= 0 {
            listRepository.removeList(id: String(self.lists[index].id))
            self.lists.remove(atOffsets: indexSet)
        }
    }
    
    func moveListOrder(indices: IndexSet, newOffset: Int){
        self.lists.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func addTasks(newTaskName: String, index: Int){
        let newTask = TaskItem(id: UUID().uuidString, title: newTaskName)
        if index < self.lists.count && index >= 0 {
            self.lists[index].tasks.append(newTask)
            listRepository.updateTasks(updatedList: self.lists[index])
        }
    }
    
    func deleteTasks(indexSet: IndexSet, index: Int){
        guard let index = indexSet.first else { return }
        if index < lists[index].tasks.count && index >= 0{
            self.lists[index].tasks.remove(atOffsets: indexSet)
            listRepository.updateTasks(updatedList: self.lists[index])
        }
    }
    
    func moveTaskOrder(indices: IndexSet, newOffset: Int, index: Int){
        self.lists[index].tasks.move(fromOffsets: indices, toOffset: newOffset)
        listRepository.updateTasks(updatedList: self.lists[index])
    }
}
