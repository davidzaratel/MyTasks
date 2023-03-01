//
//  BottomView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import Foundation
import SwiftUI


///BottomView: contains the buttons to add new lists and tasks.
struct BottomView: View {
    
    @State var showSheetTasks = false
    @State var showSheetLists = false
    
    var body: some View {
        HStack(spacing: 100){
            Button {
                showSheetTasks.toggle()
            } label: {
                HStack{
                    Image(systemName: "plus.circle")
                    Text("New Task")
                }
            }
            .sheet(isPresented: $showSheetTasks, content: {
                AddTasksView()
            })
            Button {
                showSheetLists.toggle()
            } label: {
                Image(systemName: "plus.circle")
                Text("New List")
            }
            .sheet(isPresented: $showSheetLists, content: {
                AddListsView()
            })

        }
    }
}
