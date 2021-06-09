//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskdescription: String?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?

}

extension Task : Identifiable {

}
