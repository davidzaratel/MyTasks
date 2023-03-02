//
//  Repository.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 02.03.23.
//

import Foundation
import SwiftUI

class Repository {
    @State private(set) var isLoading = false
    @State var network: Network = Network()
    
    func getLists(fromURL url: String){
        isLoading = true
            network.fetchData(fromURL: url) { returnedData in
                if let data = returnedData {
                    guard let fetchedData = try? JSONDecoder().decode([ListItem].self, from: data) else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        print("This is the fetched data", fetchedData)
                        self?.isLoading = false
                    
                    }
                } else {
                    print("The data couldn't be fetched")
                }
            }
    }
    
    
    func getUsers(fromURL url: String) {
        isLoading = true
            network.fetchData(fromURL: url) { returnedData in
                if let data = returnedData {
                    guard let fetchedData = try? JSONDecoder().decode([User].self, from: data) else {
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        print("This is the fetched data", fetchedData)
                        self?.isLoading = false
                    
                    }
                } else {
                    print("The data couldn't be fetched")
                }
            }
    }
    
    func postUsers(fromURL url: String){
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
