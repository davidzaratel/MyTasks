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
    
    func postNewList(fromURL url: URL, newListItem: ListItem) {
        //Parse the information from the newListItem into JSON
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: [
            "id": newListItem.id,
            "title": newListItem.title,
            "tasks": newListItem.tasks,
            "color": [
                "id": newListItem.color.id,
                "title": newListItem.color.title
            ]
        ], options: .prettyPrinted) else {
            print("The traslation was not possible")
            return
        }
        
        let request = createRequest(fromURL: url, method: "POST", body: jsonBody)
        network.postNewList(request: request)
    }
    
    func createRequest(fromURL url: URL, method: String, body: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
