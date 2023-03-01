//
//  AuthentificationView.swift
//  TasksApp
//
//  Created by David Zárate López on 27/02/23.
//

import Foundation
import SwiftUI

///AuthentificationView: In this UIView the user will be able to log in
struct AutenthificationView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    @State var username = ""
    @State var password = ""
    @State var loggedIn = false
    @State var userExists = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack(spacing: 30){
                    Text("MyTasks")
                        .foregroundColor(Color.white)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom, 90)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color("ListButtonColor"))
                        .frame(width: 300)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .environment(\.colorScheme, .dark)
                        .bold()
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .padding().background(Color("ListButtonColor"))
                        .frame(width: 300)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .environment(\.colorScheme, .dark)
                        .bold()
                    if userExists {
                        Text("User already exists")
                            .foregroundColor(Color.gray)
                    }
                    Button {
                        if !viewModel.isLoading {
                            registerUser()
                        }
                    } label: {
                        Text("Register")
                            .padding(.horizontal,100).padding()
                            .foregroundColor(Color.white)
                            .background(Color("AddButton"))
                            .cornerRadius(10)
                            .bold()
                    }.padding(.top, 90)
                    
                    Button {
                        //
                    } label: {
                        Text("Already have an Account? Login")
                            .foregroundColor(Color.white)
                            .bold()
                    }.padding(.bottom, 30)
                }
                if viewModel.isLoading {
                    Color.black.opacity(0.7)
                    Text("Fetching users...")
                        .foregroundColor(Color.white)
                }
            }
        }
        
    }
    
    func registerUser(){
        if viewModel.users.contains(where: {$0.username == self.username}){
            self.userExists.toggle()
        } else {
            viewModel.postNewUser(id: UUID().uuidString, username: self.username, password: self.password)
        }
    }
    
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        AutenthificationView()
    }
}

