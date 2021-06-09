//
//  TaskListModel.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import Foundation


struct TaskListModel {
    var sectionName: String
    var tasks: [Task]
}

public enum SectionNames: String {
    case Today
    case Tomorrow
    case Upcoming
}
