//
//  TasksAppApp.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import SwiftUI

@main
struct TasksAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(users: [],
                                             lists: [],
                                             isLoading: false,
                                             listRepository: ListRepository(network: Network()),
                                             userRepository: UserRepository(network: Network())
                                             ))
        }
    }
}
