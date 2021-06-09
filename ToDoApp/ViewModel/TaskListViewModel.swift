//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import Foundation
import CoreData
import UIKit

struct TaskListViewModel {
        
    static let shared = TaskListViewModel()
    
    
    func getTaskFromDatabase(){
        var todoList: [TaskListViewModel] = [TaskListViewModel(sectionName: SectionNames.Today.rawValue,tasks: []),TaskListViewModel(sectionName: SectionNames.Tomorrow.rawValue, tasks: []),TaskListViewModel(sectionName: SectionNames.Upcoming.rawValue, tasks: [])]
        
        let results = PersistancyManager.shared.retrieveTasks(predicate: nil) {[weak self] (result) in
            switch result {
            case .success(let tasks):
            
            case .failure(let error):
                UIApplication.showAlert(title: "Error!", message: error.localizedDescription)
            }
        }
    }
    
}
