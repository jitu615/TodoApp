//
//  ViewController.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "To Do App"
    }

    @IBAction func btnProceedAction(_ sender: Any) {
        if let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskListViewController") as? TaskListViewController{
            self.navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
}

