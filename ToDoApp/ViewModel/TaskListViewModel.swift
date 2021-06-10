//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import Foundation
import CoreData
import UIKit

class TaskListViewModel: NSObject {
        
    static let shared = TaskListViewModel()
    
    
    func getTaskFromDatabase(onCompletion: @escaping(_ todoList: [TaskListModel])->Void){
        var todoList: [TaskListModel] = [TaskListModel(sectionName: SectionNames.Today.rawValue,tasks: []),TaskListModel(sectionName: SectionNames.Tomorrow.rawValue,tasks: []),TaskListModel(sectionName: SectionNames.Upcoming.rawValue,tasks: [])]
        
        PersistancyManager.shared.fetchTasks(predicate: nil) { (result) in
            switch result {
            case .success(let tasks):
                let calendar = Calendar.current

                for i in 0 ..< tasks.count {
                    if let taskDate = tasks[i].createdAt {
                        if calendar.isDateInToday(taskDate) {
                            todoList[0].tasks.append(tasks[i])
                        } else if calendar.isDateInTomorrow(taskDate) {
                            todoList[1].tasks.append(tasks[i])
                        } else {
                            todoList[2].tasks.append(tasks[i])
                        }
                    }
                }
                onCompletion(todoList)
            case .failure(let _):
                onCompletion(todoList)
            }
        }
    }
    
}
