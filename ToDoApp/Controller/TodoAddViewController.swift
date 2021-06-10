//
//  TodoAddViewController.swift
//  ToDoApp
//
//  Created by snapwork  on 10/06/21.
//

import UIKit
import CoreData

class TodoAddViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedSection: String = ""
    private var model: Task = Task.init(entity: NSEntityDescription.entity(forEntityName: "Task", in:PersistancyManager.shared.getContext())!, insertInto: PersistancyManager.shared.getContext())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if selectedSection == SectionNames.Upcoming.rawValue{
            datePicker.isHidden = false
        }else{
            datePicker.isHidden = true
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        if txtTitle.text == ""{
            showAlert("Please enter title for Todo!!", title: "Error")
            return
        }
        
        model.title = txtTitle.text ?? ""
        model.taskdescription = txtDescription.text ?? ""
        if selectedSection == SectionNames.Today.rawValue{
            let todayDate = Date()
            model.createdAt = todayDate
        }
        else if selectedSection == SectionNames.Tomorrow.rawValue{
            let calendar = Calendar.current
            let today = Date()
            let midnight = calendar.startOfDay(for: today)
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
            model.createdAt = tomorrow
        }else{
            model.createdAt = datePicker.date
        }
        
        PersistancyManager.shared.saveContext { (result) in
            switch result{
            case .success():
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error): break
                //UIApplication.showAlert(title: "Error!", message: error.localizedDescription)
            }
        }
        
    }
    
}
