//
//  Network.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 01.03.23.
//

import Foundation


struct Network {
    
    // MARK: Function that fetches Any type of data
    func fetchData(urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        return data
    }
    
    // MARK: Function that executes network requests
    func executeRequest(request: URLRequest){
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do{
                let response = try JSONDecoder().decode(ListItem.self, from: data)
                print("REQUEST SUCCESS!", response)
            } catch {
                print(error)
            }
        }.resume()
    }
}
