//
//  NetworkMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

enum ReturnType {
    case user
    case list
}

enum NetworkCases {
    case success
    case failure
}

struct MockNetwork: NetworkProtocol {
    
    var networkCase: NetworkCases = .success
    var returnType: ReturnType = .list

    func fetchData<T:Codable>(fromURL url: URL) async throws -> T {
        if networkCase == .success && returnType == .user {
            guard let usersData = MockData.usersData as? T else { throw errorMessages.dataTranslationError}
            return usersData
        } else if networkCase == .success && returnType == .list {
            guard let listData = MockData.listData as? T else { throw errorMessages.dataTranslationError}
            return listData
        } else {
            throw errorMessages.networkError
        }
    }
    
    func executeRequest(request: URLRequest) {
        
    }
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data?) {
        
    }
    
}
