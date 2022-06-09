//
//  TaskController.swift
//  TaskList
//
//  Created by ПавелК on 20.03.2022.
//

import UIKit
// MARK : Protocol
protocol AddTaskDelegate : AnyObject {
    func getTasks () 
}

class AddTaskController: UIViewController {
    
    let addView = AddTaskView()
    var delegate : AddTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addView
        addTargets()
    }
   private func addTargets () {
        addView.saveButton.addTarget(self, action: #selector(writeTask), for: .touchUpInside)
    }
    
    @objc private func writeTask () {
        guard let title = addView.titleTF.text else {return}
        guard let desc = addView.descriptionTF.text else {return}
        let isUrgent = addView.isUrgentSwitch.isOn
        let isImportant = addView.isImportantSwitch.isOn
        var category: Category
        if isImportant && isUrgent {
            category = .impUrg
        } else if isUrgent && !isImportant {
            category = .notImpUrg
        } else if !isUrgent && isImportant {
            category = .impNotUrg
        } else {
            category = .notImpNotUrg
        }
        let task = Task(title: title, descript: desc, category: category)
        RealmManager.shared.writeToDB(toDo: task)
        self.delegate?.getTasks()
        self.dismiss(animated: true, completion: nil)
    }
}
