//
//  ContentView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var searchList = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    List {
                        ForEach(viewModel.lists.indices, id: \.self) { index in
                                NavigationLink {
                                    TasksView(index: index)
                                } label: {
                                    HStack{
                                        Text(viewModel.lists[index].title).padding()
                                        Spacer()
                                        Text(String(viewModel.lists[index].tasks.count)).padding()
                                    }
                                }
                                    .padding(.horizontal)
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .listRowBackground(Color(viewModel.lists[index].color.title))
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .cornerRadius(20)
                                    .bold()
                            }                                    .onDelete(perform: delete)
                                .onMove(perform: move)
                    }
                    .padding(.top)
                    .scrollContentBackground(.hidden)
//                    .searchable(text: $searchList)
                    .navigationBarItems( trailing: EditButton())
                    Spacer()
                    BottomView()
                }
            }
            .navigationTitle("My Tasks")
        }.environment(\.colorScheme, .dark)
            .environmentObject(viewModel)
    }
    
    func delete(indexSet: IndexSet) {
        viewModel.deleteList(indexSet: indexSet)
    }

    func move(indices: IndexSet, newOffset: Int){
        viewModel.moveListOrder(indices: indices, newOffset: newOffset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
