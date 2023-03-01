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


///View Model of the Class, contains the lists of Tasks of the User
class ViewModel: ObservableObject {
    @Published var lists: [ListItem] = []
    @Published private(set) var isLoading = false
    
    init(){
        getLists()
    }
    
    func getLists() {
        
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/lists") else { return }
        
        fetchData(fromURL: url) { returnedData in
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
    
    func fetchData(fromURL url: URL, completionHandler: @escaping(_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  error == nil
            else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    func postData(newListItem: ListItem){
        guard let url = URL(string: "https://localhost:3000") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let body: [String: String] = [
            "id": "",
            "title": "",
            "tasks": "",
            "color": ""
        ]
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: [
//            "id": [
//                "forecastday": [
//                    [
//                        "day": [
//                            "maxtemp_c": 1.2,
//                            "maxtemp_f": 3.4
//                        ]
//                    ],
//                    [
//                        "day": [
//                            "maxtemp_c": 5.6,
//                            "maxtemp_f": 7.8
//                        ]
//                    ]
//                ]
//            ]
//        ], options: .prettyPrinted)
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: [
//            "id": newListItem.id,
//            "title": newListItem.title,
//            "tasks": [
//                "id": newListItem.tasks.
//            ]
//        ], options: .prettyPrinted)
                
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("This is the requests final body ", request.httpBody as Any)
        print("This is the request body", body)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do{
                let response = try JSONDecoder().decode(ListItem.self, from: data)
                print("POST SUCCESS!", response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func addList(newListName: String, selectedColor: String){
        let newList = ListItem(id: UUID().uuidString, title: newListName, tasks: [], color: ColorItem(id: UUID().uuidString, title: selectedColor))
        self.postData(newListItem: newList)
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
