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
    
    func fetchData(fromURL url: URL) async throws -> [ListItem] {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedLists = try JSONDecoder().decode([ListItem].self, from: data)
        return decodedLists
    }
    
    func postNewUser(fromURL url: URL, newUser: User) {
        let body: [String: String] = [
            "id": newUser.id,
            "username": newUser.username,
            "password": newUser.password
        ]
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body) else { return }
        let request = createRequest(fromURL: url, method: "POST", body: jsonBody)
        network.postUsers(request: request)
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
        
        let request = createRequest(fromURL: url, method: method, body: jsonBody)
        network.executeRequest(request: request)
    }

    
    func createRequest(fromURL url: URL, method: String, body: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
