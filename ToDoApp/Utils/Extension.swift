//
//  Extension.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import Foundation
import UIKit


extension UITableView{
    
    func configureTableView(_ cellArray: [String],onParentVC: UIViewController){
        self.delegate = onParentVC as? UITableViewDelegate
        self.dataSource = onParentVC as? UITableViewDataSource
        cellArray.forEach { (cell) in
            self.register(UINib(nibName: cell, bundle: Bundle.main), forCellReuseIdentifier: cell)
        }
        
    }
    
    
}
