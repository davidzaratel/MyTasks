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
    var listsFiltered : [ListItem] {
        return self.searchList == "" ? viewModel.lists :
        viewModel.lists.filter {
            $0.title.lowercased().contains(self.searchList.lowercased())
        }
    }

    var body: some View {
        NavigationView {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView().frame(width: 500, height: 500, alignment: .center).scaleEffect(2)
                        Spacer()
                    } else {
                        List {
                            ForEach(listsFiltered.indices, id: \.self) { index in
                                    NavigationLink {
                                        TasksView(index: index)
                                    } label: {
                                        HStack{
                                            Text(listsFiltered[index].title)
                                            Spacer()
                                            Text(String(listsFiltered[index].tasks.count))
                                                .padding()
                                        }
                                    }
                                        .padding(.horizontal)
                                        .frame(height: 40)
                                        .frame(maxWidth: .infinity)
                                        .listRowBackground(Color(listsFiltered[index].color.title))
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 20))
                                        .cornerRadius(20)
                                        .bold()
                                }
                                .onDelete(perform: viewModel.deleteList)
                                .onMove(perform: viewModel.moveListOrder)
                        }.padding(.top, 0.5)
                        .scrollContentBackground(.hidden)
                        .searchable(text: $searchList)
                        .navigationBarItems( trailing: EditButton())
                    }
                    Spacer()
                    BottomView().padding(.top, 10)
                }
            }
            .navigationTitle("My Tasks")
            .onAppear {
                Task {
                    await viewModel.getData(urlString: Constants.listsURL)
                }
            }
        }.environment(\.colorScheme, .dark)
            .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
