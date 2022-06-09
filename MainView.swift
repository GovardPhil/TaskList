//
//  MainView.swift
//  TaskList
//
//  Created by ПавелК on 17.03.2022.
//

import UIKit

class MainView: UIView {

    var collectionView : UICollectionView
    let addButton = UIButton(title: "+", bgColor: .clear, textColor: .blue, font: FontsLibrary.largeTitle)
    let tableView = TasksTableView()

    
    init() {
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: CollectionLayoutManager.createLayout())
        super.init(frame: CGRect())
       setConstraints()
        setViews()
    }
    
    private func setViews () {
        self.collectionView.backgroundColor = .clear
        self.backgroundColor = .white
        self.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.isScrollEnabled = false
    }
    
    private func setConstraints () {
        Helper.addSub(views: [collectionView,addButton,tableView], to: self)
        Helper.tamicOff(views: [collectionView,addButton,tableView])
        
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 122).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -12).isActive = true
        addButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 48).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
