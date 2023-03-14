//
//  UsersRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation


struct UserRepository {
    private var network: Network = Network()
    
    func getAllUsers() async throws -> [User] {
        guard let url = URL(string: Constants.usersURL) else { return [] }
        return try await network.fetchData(fromURL: url)
    }
    
    func postUser(newUser: User) {
        guard let url = URL(string: Constants.usersURL) else { return }
        guard let jsonBody = createUserRequestBody(newUser: newUser) else { return }
        network.makeNetworkRequest(fromURL: url, method: "POST", body: jsonBody)
    }
    
    func createUserRequestBody(newUser: User) -> Data? {
        do {
            let jsonBody = try JSONEncoder().encode(newUser)
            return jsonBody
        } catch {
            return nil
        }
    }
}
