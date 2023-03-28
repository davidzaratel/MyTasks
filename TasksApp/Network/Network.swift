//
//  Network.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 01.03.23.
//

import Foundation


struct Network: NetworkProtocol {
    
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
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data? = nil) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.executeRequest(request: request)
    }
    
    func executeCallApiRequest(request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data , response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
               let tokenResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("SUCCESS", tokenResponse)
           }
           catch {
               print(error.localizedDescription)
           }
        
        }.resume()
    }
    
    func callAuthApi() {
        let headers = ["content-type": "application/x-www-form-urlencoded"]

        let postData = NSMutableData(data: "grant_type=password".data(using: String.Encoding.utf8)!)
        postData.append("&username=\(Constants.username)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&password=\(Constants.password)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&client_id=\(Constants.clientID)"
            .data(using: String.Encoding.utf8)!)
        postData.append("&client_secret=\(Constants.clientSecret)"
            .data(using: String.Encoding.utf8)!)
        
        guard let url = Constants.tokenApiUrl else { return }
        
        let request = NSMutableURLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        self.executeCallApiRequest(request: request as URLRequest)
    }
}
