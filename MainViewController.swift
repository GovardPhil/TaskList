//
//  ViewController.swift
//  TaskList
//
//  Created by ПавелК on 17.03.2022.
//

import UIKit

class MainViewController: UIViewController, AddTaskDelegate {
    
    let mainView = MainView()
    var tasksArray = [Task] ()
    var completedTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        setDelegateDataSource()
        addTargets()
        getTasks()
    }
    
    private func setDelegateDataSource () {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    func getTasks () {
        self.tasksArray = RealmManager.shared.getTask()
        self.completedTasks = RealmManager.shared.getTask(isComplete: true)
        mainView.tableView.reloadData()
    }
    private func addTargets () {
        mainView.addButton.addTarget(self, action: #selector(presentAddVc), for: .touchUpInside)
    }
    @objc private func presentAddVc () {
        let vc = AddTaskController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}





// MARK : Extension -> CollectionView

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
        cell.layer.cornerRadius = 16
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.imageView.contentMode  = .scaleAspectFit
        switch indexPath.item {
        case 0 :
            cell.imageView.image = UIImage(systemName: "tornado")
            cell.categoryTitleLabel.text = "Важное Срочное"
            cell.imageView.tintColor = .systemRed
            cell.imageView.alpha = 0.8
        case 1 :
            cell.imageView.image = UIImage(systemName: "tortoise")
            cell.categoryTitleLabel.text = "Важное Несрочное"
            cell.imageView.tintColor = .systemOrange
            cell.imageView.alpha = 0.8
        case 2 :
            cell.imageView.image = UIImage(systemName: "hare")
            cell.categoryTitleLabel.text = "Неважное Срочное"
            cell.imageView.tintColor = .systemBlue
            cell.imageView.alpha = 0.8
        case 3 :
            cell.imageView.image = UIImage(systemName: "shippingbox")
            cell.categoryTitleLabel.text = "Неважное Несрочное"
            cell.imageView.tintColor = .systemBrown
            cell.imageView.alpha = 0.8
        default :
            break
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category : Category
        switch indexPath.item {
        case 0 : category = .impUrg
        case 1 : category = .impNotUrg
        case 2 : category = .notImpUrg
        default : category = .notImpNotUrg
        }
        let vc = CategoryController(category: category)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK : Extension -> TableView

extension MainViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :  return tasksArray.count
        case 1 :  return completedTasks.count
        default : return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as! TaskCell
        switch indexPath.section {
        case 0 :
            switch tasksArray[indexPath.row].category {
            case Category.impUrg.rawValue :
                cell.titleLabel.text = tasksArray[indexPath.row].title
                cell.categoryIndicator.backgroundColor = .systemRed
                cell.categoryIndicator.alpha = 0.8
            case Category.impNotUrg.rawValue :
                cell.titleLabel.text = tasksArray[indexPath.row].title
                cell.categoryIndicator.backgroundColor = .systemOrange
                cell.categoryIndicator.alpha = 0.8
            case Category.notImpUrg.rawValue :
                cell.titleLabel.text = tasksArray[indexPath.row].title
                cell.categoryIndicator.backgroundColor = .systemBlue
                cell.categoryIndicator.alpha = 0.8
            case Category.notImpNotUrg.rawValue :
                cell.titleLabel.text = tasksArray[indexPath.row].title
                cell.categoryIndicator.backgroundColor = .systemBrown
                cell.categoryIndicator.alpha = 0.8
            default : break
            }
        case 1 :
            cell.titleLabel.text = completedTasks[indexPath.row].title
            cell.categoryIndicator.backgroundColor = .gray
        default : break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 : return tasksArray.count > 0 ? "Новые задачи" : nil
        case 1 : return completedTasks.count > 0 ? "Выполненные задачи" : nil
        default : return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, _ , _ in
            switch indexPath.section {
            case 0 :
                RealmManager.shared.removeFromDB(task: self.tasksArray[indexPath.row])
                self.tasksArray.remove(at: indexPath.row)
            case 1 :
                RealmManager.shared.removeFromDB(task: self.completedTasks[indexPath.row])
                self.completedTasks.remove(at: indexPath.row)
            default :
                break
            }
            tableView.reloadData()
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : TaskManager
        switch indexPath.section {
        case 0 :
             vc = TaskManager(task: tasksArray[indexPath.row])
        case 1 :
             vc = TaskManager(task: completedTasks[indexPath.row])
        default :
            return
        }
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}
