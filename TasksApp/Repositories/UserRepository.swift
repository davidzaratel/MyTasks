//
//  UsersRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation


struct UserRepository {
    private var network: Network = Network()
    
    func fetchData() async throws -> [User] {
        guard let url = URL(string: Constants.usersURL) else { return [] }
        let data = try await network.fetchData(fromURL: url)
        let decodedLists = try JSONDecoder().decode([User].self, from: data)
        return decodedLists
    }
    
    func postUser(newUser: User) {
        guard let url = URL(string: Constants.usersURL) else { return }
        makeUserRequest(fromURL: url, method: "POST", newUser: newUser)
    }
    
    func makeUserRequest(fromURL url: URL, method: String, newUser: User) {
        let body: [String: String] = [
            "id": newUser.id,
            "username": newUser.username,
            "password": newUser.password
        ]
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body) else { return }
        network.makeNetworkRequest(fromURL: url, method: method, body: jsonBody)
    }
}
