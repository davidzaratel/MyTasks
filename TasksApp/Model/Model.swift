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
    static var listsURL: URL? {
        return URL(string: "http://localhost:3000/lists")
    }
    
    static var usersURL: URL? {
        return URL(string: "http://localhost:3000/users")
    }
    static var availableColors: [String] = ["ListColor1",
                                   "ListColor2",
                                   "ListColor3",
                                   "ListColor4",
                                   "ListColor5"]
}

enum errorMessages: LocalizedError {
    case dataTranslationError
    case urlTransformationError
    case getDataRepositoryError
}

enum NetworkErrors: LocalizedError {
    case unableToFetchData
    case executeRequestError
}
