//
//  TaskManager.swift
//  TaskList
//
//  Created by ПавелК on 31.03.2022.
//

import UIKit

class TaskManager: UIViewController {

    let taskView = TaskView()
    var task : Task
    var delegate : AddTaskDelegate?
    
    init (task : Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = taskView
        setupView()
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        if task.isComplete {
            taskView.completeButton.setTitle("Выполнено", for: .disabled)
            taskView.completeButton.isEnabled = false
        }
    }
    private func addTargets () {
        taskView.completeButton.addTarget(self, action: #selector(makeComplete), for: .touchUpInside)
    }
    
    @objc private func makeComplete () {
        RealmManager.shared.makeComplete(task: task)
        delegate?.getTasks()
        self.dismiss(animated: true, completion: nil)
    }
    private func setupView () {
        taskView.titleLabel.text = task.title
        taskView.categoryLabel.text = task.category
        taskView.descriptionText.text = task.descript
    }
}
