//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by snapwork  on 09/06/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initCell(_ obj: Task){
        lblTitle.text       = obj.title
        lblDescription.text = obj.taskdescription
    }
    
}
