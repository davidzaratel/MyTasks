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
    
    @State var username = ""
    @State var password = ""
    @State var loggedIn = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack(spacing: 30){
                    Text("MyTasks").foregroundColor(Color.white).font(.system(size: 40)).bold().padding(.vertical, 60)
                    TextField("Username", text: $username).padding().background(Color("ListButtonColor")).frame(width: 250).cornerRadius(10).foregroundColor(Color.white).environment(\.colorScheme, .dark)
                    TextField("Password", text: $password).padding().background(Color("ListButtonColor")).frame(width: 250).cornerRadius(10).foregroundColor(Color.white).environment(\.colorScheme, .dark)
                    NavigationLink {
                        ContentView().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Login").padding(.horizontal,100).padding().foregroundColor(Color.white).background(Color("AddButton")).cornerRadius(10)
                    }.padding(.vertical)

                    Spacer()
                }
            }
        }
        
    }
    
    func checkUser(){
        
    }
    
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        AutenthificationView()
    }
}

