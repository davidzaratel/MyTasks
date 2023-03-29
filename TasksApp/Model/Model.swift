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
    
    static var tokenApiUrl: URL? {
        return URL(string: "https://iam.dev.dih-cloud.com/realms/development/protocol/openid-connect/token"
        )
    }
    
    static let clientID = "mobile"
    
    static let username = "David.Zarate-Lopez@t-systems.com"
    
    static let password = "Password123"
    
    static let clientSecret = "3FsKYg9RJEe9mVZVn0UVa4kcBpPsWrHl"
    
}


struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let token_type: String
}

enum errorMessages: LocalizedError {
    case dataTranslationError
    case urlTransformationError
    case getDataRepositoryError
}

enum NetworkErrors: LocalizedError {
    case unableToFetchData
    case executeRequestError
    case executeApiRequestError
    case makeRequestError
    case configureApiError
}

enum RepositoryErrors: LocalizedError {
    case getAllListsWebListError
    case getAllUsersWebUsersError
}

extension RepositoryErrors {
    var errorDescription: String? {
        switch self {
        case .getAllListsWebListError:
            return "Failed to retrieve lists data"
        case .getAllUsersWebUsersError:
            return "Failed to retrieve users data"
        }
    }
}
