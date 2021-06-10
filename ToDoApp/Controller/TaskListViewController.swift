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
    
    let viewModel: TaskListViewModel = TaskListViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblTodo.configureTableView([reusableIdentifier], onParentVC: self)
        
        viewModel.getTaskFromDatabase{ (todoList) in
            self.todoList = todoList
            self.tblTodo.reloadData()
        }
    }
    
}

extension TaskListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return todoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as! TaskTableViewCell
        taskCell.initCell(todoList[indexPath.section].tasks[indexPath.row])
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        sectionHeader.backgroundColor = .lightGray
        
        let title: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 120, height: 30))
        title.text = todoList[section].sectionName
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 12)
        
        let button = UIButton(frame: CGRect(x: tableView.frame.size.width - 60, y: 10, width: 60, height: 30))
        button.setImage(UIImage(named: "add"), for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(btnAddAction(_:)), for: .touchUpInside)
        
        sectionHeader.addSubview(title)
        sectionHeader.addSubview(button)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            fatalError()
        }
        let taskModel = todoList[indexPath.section].tasks[indexPath.row]
        
        tableView.beginUpdates()
        
        todoList[indexPath.section].tasks.remove(at: indexPath.row)
        PersistancyManager.shared.deleteTask(task: taskModel)
        
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        tableView.endUpdates()
    }
    
    
    //
    @objc func btnAddAction(_ sender: UIButton){
        let section = sender.tag
        if let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodoAddViewController") as? TodoAddViewController{
            if section == 0{
                addVC.selectedSection = SectionNames.Today.rawValue
            }
            else if section == 1{
                addVC.selectedSection = SectionNames.Tomorrow.rawValue
            }else{
                addVC.selectedSection = SectionNames.Upcoming.rawValue
            }
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }
}
