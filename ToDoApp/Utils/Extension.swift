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
extension  UIViewController{
    
    func showAlert(_ message: String,title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
