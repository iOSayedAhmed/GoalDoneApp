//
//  FinishGoalVC.swift
//  GoalDone
//
//  Created by Develop on 2/9/20.
//  Copyright © 2020 Develop. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsGoalTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.createGoalBtn.bindToKeyboard() 
        pointsGoalTextField.delegate = self
              NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
                            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
     
    }
    @IBOutlet weak var constrainOfCreateGoalBtn: NSLayoutConstraint!
    
    
    var goalDescription : String!
    var goalType : GoalType!
    func initData (description: String , type : GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    @IBAction func createGoalBtnWasPressed(_ sender: UIButton) {
        if pointsGoalTextField.text != "" {
            save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)  }
            }
        }
    }
    @IBAction func backBtnWasPressed(_ sender: UIButton) {
        dismissDetail()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //pointsGoalTextField.text = ""
        pointsGoalTextField.textColor = #colorLiteral(red: 0.02543864489, green: 0.5072176396, blue: 0.1605761218, alpha: 1)
    }
    
    //MARK:- Function to Save Data into CoreData
    func save(completion:(_ finish:Bool )-> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal.init(context: manageContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalComplationValue = Int32(pointsGoalTextField.text ?? "")!
        goal.goalProgress = Int32(0)
        do {
            try manageContext.save()
            print("Successfully Saved")
            completion(true)
        } catch {
            completion(false)
            debugPrint("Couldn't Save \(error.localizedDescription)")
        }
    }
    @objc func keyboard(notification:Notification) {
                    guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
                        return
                    }

                    if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
                        self.view.frame.origin.y = -keyboardReact.height
                    }else{
                        self.view.frame.origin.y = 0
                    }

                }
}
