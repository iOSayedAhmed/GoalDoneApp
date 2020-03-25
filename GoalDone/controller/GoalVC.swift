//  GoalVC.swift
//  GoalDone
//  Created by Develop on 2/2/20.
//  Copyright © 2020 Develop. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalVC: UIViewController {
    var goals:[Goal] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCoreDataObject()
        tableView.reloadData()
    }
    
    func fetchCoreDataObject (){
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1
                {
                    tableView.isHidden = false
                }else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func AddGoalBtnWasPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier:"creatGoalVC") else {return}
       presentDetail(createGoalVC)
    }
}

//MARK:- Extension ---> TableView

extension GoalVC: UITableViewDelegate , UITableViewDataSource   {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goals.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? goalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
   
    // To remove (Delete) Row of TableView by indexPath

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(indexPath: indexPath)
            self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atInsexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        return [deleteAction , addAction]
    }
}
    

//MARK:- Extension ---> Function for CoreData

extension GoalVC {
    func setProgress(atInsexPath indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalComplationValue > chosenGoal.goalProgress {
            chosenGoal.goalProgress += 1
        }else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            debugPrint("Couldn't SetProgress \(error.localizedDescription)")
        }
    }
    
    func removeGoal(indexPath indexpath:IndexPath){
    guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    managedContext.delete(goals[indexpath.row])
    do {
        try managedContext.save()
        print("Successfully Deleted")
    } catch {
        debugPrint("Couldn't Deleted\(error.localizedDescription)")
    }
    }
    func fetch( completion:(_ complete:Bool) ->() ){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            print(" Successfully Fetched")
            completion(true)
        } catch {
            debugPrint("Couldn't Fetched \(error.localizedDescription)")
            completion(false)
        }
    }
   
    
}
