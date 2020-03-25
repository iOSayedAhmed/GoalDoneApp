//
//  goalCell.swift
//  GoalDone
//
//  Created by Develop on 2/2/20.
//  Copyright © 2020 Develop. All rights reserved.
//

import UIKit

class goalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    @IBOutlet weak var completeView: UIView!
    
    func configureCell (goal: Goal) {
self.goalDescriptionLbl.text = goal.goalDescription
    self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        if goal.goalProgress == goal.goalComplationValue {
            completeView.isHidden = false
        }else {
            completeView.isHidden = true
        }
        
}
}
