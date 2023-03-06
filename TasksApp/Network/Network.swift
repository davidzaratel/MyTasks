//
//  Network.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 01.03.23.
//

import Foundation


struct Network {
    
    // MARK: Fetching data from the users with HTTP request
    func fetchData(fromURL url: URL, completionHandler: @escaping(_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    
    // MARK: Posting a newList from the user from the users with HTTP request
    func postNewList(request: URLRequest){
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do{
                let response = try JSONDecoder().decode(ListItem.self, from: data)
                print("POST SUCCESS!", response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postUsers(request: URLRequest){
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let response = try JSONDecoder().decode(User.self, from: data)
                print("POST SUCCESS!", response)
            } catch {
                print(error)
            }
        }.resume()
    }

}
