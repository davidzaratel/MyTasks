//
//  ListRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation

struct WebListRepository: ListRepository {
    
    var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getAllLists() async throws -> [ListItem] {
        guard let url = Constants.listsURL else { return [] }
        do {
            return try await network.fetchData(fromURL: url)
        } catch {
            throw RepositoryErrors.getAllListsWebListError
        }
    }
    
    func addList(newList: ListItem) {
        guard let url = Constants.listsURL else { return }
        guard let jsonBody = createListRequestBody(newListItem: newList) else { return }
        network.makeNetworkRequest(fromURL: url, method: "POST",
                                   body: jsonBody, headers: nil)
    }
        
    func removeList(id: String) {
        guard let url = Constants.listsURL?.appending(path: id)
        else { return }
        network.makeNetworkRequest(fromURL: url, method: "DELETE",
                                   body: nil, headers: nil)
    }
    
    func updateTasks(updatedList: ListItem) {
        guard let url = Constants.listsURL?.appending(path: updatedList.id)
        else { return }
        guard let jsonBody = createListRequestBody(newListItem: updatedList) else { return }
        network.makeNetworkRequest(fromURL: url, method: "PUT",
                                   body: jsonBody, headers: nil)
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
