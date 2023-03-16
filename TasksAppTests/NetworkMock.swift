//
//  NetworkMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

struct NetworkMock: NetworkProtocol {
    
    var fetchedData: Codable? = nil
    
    func fetchData<T:Codable>(fromURL url: URL) async throws -> T {
        guard let fetchedData = fetchedData as? T else { throw errorMessages.dataTranslationError}
        return fetchedData
    }
    
    func executeRequest(request: URLRequest) {
        
    }
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data?) {
        
    }
    
    
}
