//
//  NetworkMock.swift
//  TasksAppTests
//
//  Created by David Zarate-Lopez on 16.03.23.
//

import Foundation
@testable import TasksApp

enum ReturnType {
    case user
    case list
}

enum NetworkCases {
    case success
    case failure
}

struct NetworkMock: NetworkProtocol {
    
    var networkCase: NetworkCases = .success
    var returnType: ReturnType = .list
    
    var listData = [
        TasksApp.ListItem(
        id: "E3EF0626-E652-4A34-A414-3F24B9C4EDE1",
        title: "T-Systems",
        tasks: [
            TasksApp.TaskItem(id: "C3A4ECF0-31CE-4EDC-8CAB-1FBBF045AA2D", title: "Send email to coworker"),
            TasksApp.TaskItem(id: "15C0D448-E363-4FD8-9089-4B532F469FC3", title: "Yeah"),
            TasksApp.TaskItem(id: "FDFB8EF3-10EA-4EF6-81C0-AABE7A6B602E", title: "Jdald")],
        color: TasksApp.ColorItem(id: "7D4B8C42-5750-4BE5-80D4-5B6C76432DAC", title: "ListColor2"))

        ,TasksApp.ListItem(
            id: "42A5871A-C425-419C-9290-C2D453431ABB",
            title: "Telekom",
            tasks: [
                TasksApp.TaskItem(id: "D89EB89B-FAE8-4907-8EC3-54F99BE5EBD8", title: "Dasd")],
            color: TasksApp.ColorItem(id: "5ABF3575-4976-4682-B0E4-27A157FE791D", title: "ListColor5"))
    ]
    
    var usersData = [
        TasksApp.User(id: "F3AF36DB-295F-48D2-9F11-1278D2D54033", username: "davidzaratel", password: "aaaa"),
        TasksApp.User(id: "09DC323C-7014-448C-A6ED-C8DEF8D6E01F", username: "dasdf", password: "fdasd"),
        TasksApp.User(id: "48593DAB-29AA-4C7E-B1F7-6946F0453BEE", username: "newuser", password: "jaeofdj"),
        TasksApp.User(id: "C6D66890-4A04-4C83-8CEC-5BC472F4C3EA", username: "dsad", password: "asdsad"),
        TasksApp.User(id: "868B9219-8C43-42BA-96DC-9F0116E3583D", username: "adasds", password: "sdsass"),
        TasksApp.User(id: "56421B0D-8B50-47F0-9369-FE69FA284BB8", username: "assk", password: "dasdsa")
    ]

    func fetchData<T:Codable>(fromURL url: URL) async throws -> T {
        if networkCase == .success && returnType == .user {
            guard let usersData = usersData as? T else { throw errorMessages.dataTranslationError}
            return usersData
        } else if networkCase == .success && returnType == .list {
            guard let listData = listData as? T else { throw errorMessages.dataTranslationError}
            return listData
        } else {
            throw errorMessages.networkError
        }
    }
    
    func executeRequest(request: URLRequest) {
        
    }
    
    func makeNetworkRequest(fromURL url: URL, method: String, body: Data?) {
        
    }
    
}
