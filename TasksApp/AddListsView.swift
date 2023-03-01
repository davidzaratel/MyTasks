//
//  AddListsView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import Foundation
import SwiftUI

///AddListsView: Allows the user to create a new list with a color of their choice
struct AddListsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var selectedColor = ""
    let availableColors = ["ListColor1",
                           "ListColor2",
                           "ListColor3",
                           "ListColor4",
                           "ListColor5"]
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack(spacing: 50){
                Text("New List").foregroundColor(Color.white).font(.system(size: 30)).bold().padding(.vertical,30)
                TextField("Title", text: $title).padding().background(Color("ListButtonColor")).frame(width: 250).cornerRadius(10).foregroundColor(Color.white).environment(\.colorScheme, .dark)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20 ){
                        ForEach(availableColors, id: \.self ){ color in
                            Button {
                                self.selectedColor = color
                            } label: {
                                ZStack {
                                    if self.selectedColor == color {
                                        Text("").frame(width: 60, height: 60).background(Color.white).cornerRadius(100)
                                    }
                                    Text("").frame(width: 50, height: 50).background(Color(color)).cornerRadius(100)
                                }
                                
                            }
                        }
                    }.padding()
                }.padding()
                Button {
                    addList()
                } label: {
                    Text("Add").padding(.horizontal,100).padding().foregroundColor(Color.white).background(Color("AddButton")).cornerRadius(10)
                }.padding(.vertical)
                Spacer()
            }
        }
    }
    
    
    func addList(){
        viewModel.addList(newListName: self.title, selectedColor: selectedColor)
        title = ""
        presentationMode.wrappedValue.dismiss()
    }
}
