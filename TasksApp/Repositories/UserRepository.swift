//
//  UsersRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation


struct UserRepository: UserRepositoryProtocol {
    var network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getAllUsers() async throws -> [User] {
        guard let url = Constants.usersURL else { return [] }
        return try await network.fetchData(fromURL: url)
    }
    
    func postUser(newUser: User) {
        guard let url = Constants.usersURL else { return }
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
