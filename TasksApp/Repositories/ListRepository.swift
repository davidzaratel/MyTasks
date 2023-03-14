//
//  ListRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation

struct ListRepository {
    private var network: Network = Network()
    
    func fetchData() async throws -> [ListItem]{
        guard let url = URL(string: Constants.listsURL) else { return [] }
        let data = try await network.fetchData(fromURL: url)
        let decodedLists = try JSONDecoder().decode([ListItem].self, from: data)
        return decodedLists
    }
    
    func postList(newList: ListItem) {
        guard let url = URL(string: Constants.listsURL) else { return }
        makeListRequest(fromURL: url, method: "POST", newListItem: newList)
    }
        
    func deleteList(id: String) {
            guard let url = URL(string: Constants.getParamURL(url: Constants.listsURL, params: id))
            else { return }
            var request = URLRequest(url:url)
            request.httpMethod = "DELETE"
            network.executeRequest(request: request)
    }
    
    func updateTasks(updatedList: ListItem) {
        guard let url = URL(string: Constants.getParamURL(url: Constants.listsURL, params: String(updatedList.id)))
        else { return }
        makeListRequest(fromURL: url, method: "PUT", newListItem: updatedList)
    }
    
    func makeListRequest(fromURL url: URL, method: String, newListItem: ListItem) {
        let tasks : [[String: String]] = newListItem.tasks.map {[ "id": $0.id, "title": $0.title]}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: [
            "id": newListItem.id,
            "title": newListItem.title,
            "tasks": tasks,
            "color": [ "id": newListItem.color.id, "title": newListItem.color.title]
        ], options: .prettyPrinted) else {
            print("The traslation was not possible")
            return
        }
        network.makeNetworkRequest(fromURL: url, method: method, body: jsonBody)
    }
}
