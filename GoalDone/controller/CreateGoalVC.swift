//
//  CreateGoalVC.swift
//  GoalDone
//
//  Created by Develop on 2/6/20.
//  Copyright © 2020 Develop. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController , UITextViewDelegate  {

     var goalType: GoalType = .ShortTem
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var ShortTermBtn: UIButton!
    @IBOutlet weak var LongTermBtn: UIButton!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.bindToKeyboard()
        ShortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
      goalTextView.delegate = self
        goalTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        
    }
    
    @IBAction func ShortTermBtnWasPressed(_ sender: Any) {
        goalType = .ShortTem
        ShortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
    }
    
    @IBAction func LongTermBtnWasPressed(_ sender: Any) {
        goalType = .LongTerm
        LongTermBtn.setSelectedColor()
        ShortTermBtn.setDeselectedColor()
        
    }
    
    
    
    @IBAction func NextBtnWasPreswed(_ sender: UIButton) {
        if goalTextView.text != "" && goalTextView.text != "What's Your Goal?" {
        guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
        finishGoalVC.initData(description: goalTextView.text ?? "", type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func BackBtnWasPressed(_ sender: UIButton) {
dismissDetail()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
