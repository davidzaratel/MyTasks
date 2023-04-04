//
//  UsersRepository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 14.03.23.
//

import Foundation


struct WebUserRepository: UserRepository {
    
    var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getAllUsers() async throws -> [User] {
        guard let url = Constants.usersURL else { return [] }
        do {
            return try await network.fetchData(fromURL: url)
        } catch {
            throw RepositoryErrors.getAllUsersWebUsersError
        }
    }
    
    func addUser(newUser: User) {
        guard let url = Constants.usersURL else { return }
        guard let jsonBody = createUserRequestBody(newUser: newUser) else { return }
        do {
            try network.makeNetworkRequest(fromURL: url, method: "POST",
                                       body: jsonBody, headers: nil)
        } catch {
            print(error)
        }
    }
    
    func createUserRequestBody(newUser: User) -> Data? {
        do {
            let jsonBody = try JSONEncoder().encode(newUser)
            return jsonBody
        } catch {
            return nil
        }
    }
    
    func authenticateUser (username: String, password: String) throws {
        do {
            try network.configureAuthApiCall(username: username, password: password)
        } catch {
            throw RepositoryErrors.authenticateUserError
        }
    }
}
