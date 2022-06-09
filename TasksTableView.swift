//
//  TasksTableView.swift
//  TaskList
//
//  Created by ПавелК on 24.03.2022.
//


import UIKit
class TasksTableView : UITableView {
    
    init () {
        super.init(frame: CGRect(), style: .plain)
        self.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        self.backgroundColor = .clear
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
