//
//  Democell.swift
//  HW3
//
//  Created by 오성진 on 10/7/23.
//

import UIKit

class Democell : UITableViewCell{
    let movieImage = UIImageView()
    let textlabel = UILabel()
    let playImage = UIImageView()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        contentView.addSubview(movieImage)
        contentView.addSubview(textlabel)
        contentView.addSubview(playImage)
        setUplabel()
    }
    
    func setUplabel(){
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            
            textlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textlabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
        ])
    }
}
