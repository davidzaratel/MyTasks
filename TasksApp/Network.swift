//
//  Network.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 01.03.23.
//

import Foundation


struct Network {
    
    func fetchData(fromURL url: String, completionHandler: @escaping(_ data: Data?) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  error == nil
            else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    func postData(fromURL url: String, newListItem: ListItem){
        guard let url = URL(string: "http://localhost:3000/lists") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let body: [String: String] = [
            "id": "",
            "title": "",
            "tasks": "",
            "color": ""
        ]
        
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: [
//            "id": [
//                "forecastday": [
//                    [
//                        "day": [
//                            "maxtemp_c": 1.2,
//                            "maxtemp_f": 3.4
//                        ]
//                    ],
//                    [
//                        "day": [
//                            "maxtemp_c": 5.6,
//                            "maxtemp_f": 7.8
//                        ]
//                    ]
//                ]
//            ]
//        ], options: .prettyPrinted)
        
//        let jsonData = try! JSONSerialization.data(withJSONObject: [
//            "id": newListItem.id,
//            "title": newListItem.title,
//            "tasks": [
//                "id": newListItem.tasks.
//            ]
//        ], options: .prettyPrinted)
                
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("This is the requests final body ", request.httpBody as Any)
        print("This is the request body", body)
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
    
    func postUsers(fromURL url: String, newUser: User){
        guard let url = URL(string: "http://localhost:3000/users") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let body: [String: String] = [
            "id": newUser.id,
            "username": newUser.username,
            "password": newUser.password
        ]
                
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
