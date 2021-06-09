//
//  ViewController.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.saveTask()
        viewModel.retreiveTask()
    }


}

