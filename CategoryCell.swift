//
//  CategoryCell.swift
//  TaskList
//
//  Created by ПавелК on 17.03.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    let imageView = UIImageView(image: UIImage(systemName: "hare.fill"))
    let categoryTitleLabel = UILabel(text: "Имя категории", font: FontsLibrary.smallButton)
    static let reuseId = "CategoryCell"
    
    override init (frame : CGRect) {
        super.init(frame: frame)
        setConstraints()
        backgroundColor = .white
        categoryTitleLabel.textAlignment = .center
    }
    private func setConstraints () {
        let stack = UIStackView(views: [imageView,categoryTitleLabel], axis: .vertical, spacing: 2)
        Helper.tamicOff(views: [stack])
        Helper.addSub(views: [stack], to: self)
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
