//
//  Democell.swift
//  HW3
//
//  Created by 오성진 on 10/20/23.
//

import UIKit

class Democell: UITableViewCell {
    let customTextLabel = UILabel() // Change the name to avoid conflict
    let addImageView = UIImageView() // Assuming you want to display images
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customTextLabel) // Update to customTextLabel
        contentView.addSubview(addImageView)
        setUpLabel()
        setUpImageView()
    }
    
    func setUpLabel() {
        customTextLabel.translatesAutoresizingMaskIntoConstraints = false // Update to customTextLabel
        NSLayoutConstraint.activate([
            customTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // Update to customTextLabel
            customTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15) // Update to customTextLabel
        ])
    }
    
    func setUpImageView() {
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            addImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            addImageView.widthAnchor.constraint(equalToConstant: 40), // Adjust the width as needed
            addImageView.heightAnchor.constraint(equalToConstant: 40) // Adjust the height as needed
        ])
    }
}
