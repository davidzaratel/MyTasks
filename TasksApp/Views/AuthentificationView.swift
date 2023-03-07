//
//  AuthentificationView.swift
//  TasksApp
//
//  Created by David Zárate López on 27/02/23.
//

import Foundation
import SwiftUI

///AuthentificationView: In this UIView the user will be able to log in
struct AutentificationView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    @State var username = ""
    @State var password = ""
    @State var loggedIn = false
    @State var loginMessage = ""
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack(spacing: 30){
                    Text("MyTasks")
                        .foregroundColor(Color.white)
                        .font(.system(size: 40))
                        .bold()
                    Text("Please enter your username or create a new one")
                        .padding()
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color("ListButtonColor"))
                        .frame(width: 300)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .environment(\.colorScheme, .dark)
                        .bold()
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $password)
                        .padding().background(Color("ListButtonColor"))
                        .frame(width: 300)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .environment(\.colorScheme, .dark)
                        .bold()
                    Text(loginMessage)
                        .foregroundColor(Color.gray)
                        .frame(height: 30)
                    Button {
                        if !viewModel.isLoading {
                            registerUser()
                        }
                    } label: {
                        Text("Login")
                            .padding(.horizontal,100).padding()
                            .foregroundColor(Color.white)
                            .background(Color("AddButton"))
                            .cornerRadius(10)
                            .bold()
                    }.padding(.top, 90)
                    
                }
                if viewModel.isLoading {
                    Color.black.opacity(0.7)
                    Text("Fetching users...")
                        .foregroundColor(Color.white)
                }
            }.onAppear {
                Task {
                    await viewModel.getData(urlString: Constants.usersURL)
                }
            }
        }
        
    }
    
    func registerUser(){
        let fieldsCompleted = (self.username != "" && self.password != "") ?
            true : false
        if viewModel.users.contains(where: {$0.username == self.username}){
            if viewModel.users.contains(where: {$0.password == self.password}) {
                self.loginMessage = "Logged in correctly"
            } else {
                self.loginMessage = "Wrong password"
            }
        } else {
            if fieldsCompleted {
                viewModel.postNewUser(id: UUID().uuidString, username: self.username, password: self.password)
                loginMessage = "Registered correctly"
            } else {
                self.loginMessage = "Please fill both fields"
            }
        }
    }
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        AutentificationView()
    }
}

