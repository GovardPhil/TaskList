//
//  RealmManager.swift
//  TaskList
//
//  Created by ПавелК on 21.03.2022.
//

import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    static let shared = RealmManager()
    
    private init () {}
    
    func printConfig () {
        print(realm.configuration.fileURL ?? "NONE")
    }

    func writeToDB (toDo : Task) {
        try! realm.write {
            realm.add(toDo)
        }
    }
    func removeFromDB (task : Task) {
        try! realm.write({
            realm.delete(task)
        })
    }
    func makeComplete (task : Task) {
        try! realm.write ({
            task.isComplete = true
        })
    }
    func getTask (category : Category? = nil, isComplete : Bool? = nil) -> [Task] {
        
        var tasks = [Task]()
        let tasksInDb = realm.objects(Task.self)
        if let category = category {
            for task in tasksInDb where task.category == category.rawValue && !task.isComplete {
                tasks.append(task)
            }
        } else if isComplete != nil {
            for task in tasksInDb where task.isComplete {
                tasks.append(task)
            }
        } else {
            for task in tasksInDb where !task.isComplete {
                tasks.append(task)
            }
        }
        return tasks
    }
}
