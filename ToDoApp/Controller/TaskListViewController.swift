//
//  TaskListViewController.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import UIKit
import Foundation
import CoreData

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tblTodo: UITableView!
    private var reusableIdentifier: String = "TaskTableViewCell"

    //
    var todoList: [TaskListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblTodo.configureTableView([reusableIdentifier], onParentVC: self)
        
        
    }
    
}

extension TaskListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as! TaskTableViewCell
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
