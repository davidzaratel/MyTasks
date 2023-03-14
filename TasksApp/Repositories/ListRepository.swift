//
//  ListRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation

struct ListRepository {
    private var network: Network = Network()
    
    func getAllLists() async throws -> [ListItem] {
        guard let url = URL(string: Constants.listsURL) else { return [] }
        return try await network.fetchData(fromURL: url)
    }
    
    func addList(newList: ListItem) {
        guard let url = URL(string: Constants.listsURL) else { return }
        guard let jsonBody = createListRequestBody(newListItem: newList) else { return }
        network.makeNetworkRequest(fromURL: url, method: "POST", body: jsonBody)
    }
        
    func removeList(id: String) {
        guard let url = URL(string: Constants.listsURL)?.appending(path: id)
        else { return }
        network.makeNetworkRequest(fromURL: url, method: "DELETE", body: nil)
    }
    
    func updateTasks(updatedList: ListItem) {
        guard let url = URL(string: Constants.listsURL)?.appending(path: updatedList.id)
        else { return }
        guard let jsonBody = createListRequestBody(newListItem: updatedList) else { return }
        network.makeNetworkRequest(fromURL: url, method: "PUT", body: jsonBody)
    }
    
    func createListRequestBody(newListItem: ListItem) -> Data? {
        do {
            let jsonBody = try JSONEncoder().encode(newListItem)
            return jsonBody
        } catch {
            return nil
        }
    }
}
