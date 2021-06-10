//
//  PersisttancyManager.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import Foundation
import CoreData
import UIKit

class PersistancyManager: NSObject{
    
    //Entity Key
    private let entityName: String          = "Task"
    
    //Attributes Key
    private let attributeTitle: String      = "title"
    private let attributeDesc: String       = "taskdescription"
    private let attributeCreatedAt: String  = "createdAt"
    
    //Singleton Object
    public static let shared: PersistancyManager = PersistancyManager()


    
    public func getContext()->NSManagedObjectContext{
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2
        let managedContext =
          appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    //MARK:-  FETCH DATA
    public func fetchTasks(predicate: NSPredicate?,  completion: @escaping (Result<[Task], Error>) -> Void){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        request.predicate = predicate
        do {
            let tasks = try getContext().fetch(request)
            completion(.success(tasks))
        } catch {
           // completion(.failure(CustomError.CoreDataError))
        }
    }
    
    //MARK:- ADDS NEW TASK INTO DATABASE
    public func saveContext(completion: @escaping (Result<Void, Error>) -> Void = {_ in }) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let container = appDelegate.persistentContainer
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                completion(.success(Void()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    //MARK:-DELETE RECORD
    public func deleteTask(task: Task) {
        getContext().delete(task)
        try? getContext().save()
    }
    
    //MARK:-CHECK FOR RECORD  IF ALREADY EXIST
    func checkForRecord(_ text: String)->Bool{
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return false
              }
              
        // ManagedContext Object
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "\(attributeTitle) == %@", text)
        request.predicate = predicate
        request.fetchLimit = 1

        do{
            let count = try managedContext.count(for: request)
            if(count == 0){
            // no matching object
                return false
            }
            else{
            // at least one matching object exists
                return true
            }
          }
        catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
          }
        return false
    }
    
    
    
}

