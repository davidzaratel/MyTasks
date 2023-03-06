//
//  Model.swift
//  TasksApp
//
//  Created by David Zarate-Lopez on 02.03.23.
//

import Foundation
import SwiftUI

struct ListItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
    var tasks: [TaskItem]
    var color: ColorItem
}

struct TaskItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
}

struct ColorItem: Hashable, Codable, Identifiable {
    var id : String
    var title: String
}

struct User: Hashable, Codable, Identifiable  {
    var id: String
    var username: String
    var password: String
}

struct Constants {
    static var listsURL: String = "http://localhost:3000/lists"
    static var usersURL: String = "http://localhost:3000/users"
}
