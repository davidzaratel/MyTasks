//
//  AddTasksView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import Foundation
import SwiftUI

///AddTasksView: Allows the user to add a new task in a certain list 
struct AddTasksView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var listSelected = 0
    @EnvironmentObject var viewModel: ViewModel
    
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack(spacing: 50){
                Text("New Task").foregroundColor(Color.white).font(.system(size: 30)).bold().padding(.vertical,30)
                TextField("Title", text: $title).padding().background(Color("ListButtonColor")).frame(width: 250).cornerRadius(10).foregroundColor(Color.white).environment(\.colorScheme, .dark)
                Picker(selection: $listSelected) {
                    ForEach(viewModel.lists.indices, id: \.self){ index in
                        Text(viewModel.lists[index].title).tag(index)
                    }
                } label: {
                    Text("Picker")
                }.pickerStyle(WheelPickerStyle())
                Button {
                    addTask()
                } label: {
                    Text("Add").padding(.horizontal,100).padding().foregroundColor(Color.white).background(Color("AddButton")).cornerRadius(10)
                }.padding(.vertical)
                Spacer()
            }.environment(\.colorScheme, .dark)
        }
    }
    
    
    func addTask(){
        viewModel.addTasks(newTaskName: title, index: listSelected)
        title = ""
        presentationMode.wrappedValue.dismiss()
    }
}
