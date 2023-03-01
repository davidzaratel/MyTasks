//
//  ContentView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    ScrollView{
                        VStack(spacing: 25) {
                            if viewModel.isLoading {
                            Spacer()
                            ProgressView().frame(width: 500, height: 500, alignment: .center).scaleEffect(2)
                            Spacer()                            
                            } else {
                                ForEach(viewModel.lists.indices, id: \.self) { index in
                                    HStack{
                                        NavigationLink {
                                            TasksView(index: index)
                                        } label: {
                                            HStack{
                                                Text(viewModel.lists[index].title).padding()
                                                Spacer()
                                                Text(String(viewModel.lists[index].tasks.count)).padding()
                                            }
                                            .frame(height: 70)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(viewModel.lists[index].color.title))
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 20))
                                            .cornerRadius(20)
                                            .bold()
                                        }.padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }.padding(.vertical, 30)
                    Spacer()
                    BottomView()
                }
            }
            .navigationTitle("My Tasks")
        }.environment(\.colorScheme, .dark)
            .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
