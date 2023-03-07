//
//  Repository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 02.03.23.
//

import Foundation
import SwiftUI

class Repository {
    @State private(set) var isLoading = false
    @State var network: Network = Network()
    
    func fetchData<T:Codable> (fromURL url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        let data = try await network.fetchData(urlRequest: urlRequest)
        let decodedLists = try JSONDecoder().decode(T.self, from: data)
        return decodedLists
    }
    
    func makeUserRequest(fromURL url: URL, method: String, newUser: User) {
        let body: [String: String] = [
            "id": newUser.id,
            "username": newUser.username,
            "password": newUser.password
        ]
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body) else { return }
        makeNetworkRequest(fromURL: url, method: method, body: jsonBody)
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
        makeNetworkRequest(fromURL: url, method: method, body: jsonBody)
    }

    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        network.executeRequest(request: request)
    }
}
