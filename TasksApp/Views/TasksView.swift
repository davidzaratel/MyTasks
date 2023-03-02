//
//  TasksView.swift
//  TasksApp
//
//  Created by David Zárate López on 21/02/23.
//

import Foundation
import SwiftUI

///TaskView: UIView that contains the list of tasks of a certain list selected by the user
struct TasksView: View {
    
    var index: Int = 0
    @State var searchTask = ""
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
            List {
                Section(header: Text("Tasks")) {
                    ForEach(tasksList, id: \.self){ task in
                        Text(task.capitalized)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .searchable(text: $searchTask)
            .navigationTitle(viewModel.lists[index].title)
            .navigationBarItems( trailing: EditButton())
    }
    
    func delete(indexSet: IndexSet) {
        viewModel.deleteTasks(indexSet: indexSet, index: self.index)
    }
    
    func move(indices: IndexSet, newOffset: Int){
        viewModel.moveTaskOrder(indices: indices, newOffset: newOffset, index: self.index)
    }
    
    var tasksList : [String] {
        let lowercaseList = viewModel.lists[self.index].tasks.map {$0.title.lowercased()}
        
        return self.searchTask == "" ? lowercaseList : lowercaseList.filter {
            $0.contains(self.searchTask.lowercased())
        }
    }
}
