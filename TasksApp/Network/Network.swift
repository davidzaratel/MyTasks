//
//  Network.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 01.03.23.
//

import Foundation


class Network: NetworkProtocol {
    
    var userToken: AuthResponse?
    
    func fetchData<T:Codable> (fromURL url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { throw NetworkErrors.unableToFetchData }
        let decodedLists = try JSONDecoder().decode(T.self, from: data)
        return decodedLists
    }
    
    // MARK: Function that executes network requests
    func executeRequest(request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(ListItem.self, from: data)
                print("REQUEST SUCCESS!", response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func makeNetworkRequest(fromURL url: URL,
                            method: String,
                            body: Data? = nil,
                            headers: [String : String]? = nil) {
        let request = NSMutableURLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0
                                 )
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.executeRequest(request: request as URLRequest)
    }
    
    func executeCallApiRequest(request: URLRequest) async throws {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { throw NetworkErrors.executeApiRequestError }
        self.userToken = try JSONDecoder().decode(AuthResponse.self, from: data)
    }
    
    func configureAuthApiCall(username: String, password: String) async throws {
        let headers = ["content-type": "application/x-www-form-urlencoded"]

        let postData = NSMutableData(data: "grant_type=password".data(using: String.Encoding.utf8)!)
        postData.append("&username=\(username)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&password=\(password)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&client_id=\(Constants.clientID)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&client_secret=\(Constants.clientSecret)"
            .data(using: String.Encoding.utf8)!)
        
        guard let url = Constants.tokenApiUrl else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        try await executeCallApiRequest(request: request)
    }
}
