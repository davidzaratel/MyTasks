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
            let network = Network()
            ContentView(viewModel: ViewModel(listRepository: WebListRepository(network: network),
                                             userRepository: WebUserRepository(network: network)
                                             ))
        }
    }
}
