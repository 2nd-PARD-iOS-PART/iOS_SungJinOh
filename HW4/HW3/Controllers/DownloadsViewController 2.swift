//
//  DownloadsViewController.swift
//  HW3
//
//  Created by 오성진 on 9/29/23.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 이미지 뷰 생성 및 설정
        let imageView = UIImageView(image: UIImage(named: "downloadbutton.png"))
        imageView.contentMode = .center // 이미지를 중앙에 맞추도록 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 레이블 생성 및 설정
        let textLabel = UILabel()
        textLabel.text = "Movies and TV shows that you\ndownload appear here."
        textLabel.textColor = .gray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2 // 여러 줄로 표시하도록 설정
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 버튼 생성 및 설정
        let button = UIButton(type: .system)
        button.setTitle("Find Something to Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰 계층에 추가
        view.addSubview(imageView)
        view.addSubview(textLabel)
        view.addSubview(button)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 270), // 버튼의 폭 설정
            button.heightAnchor.constraint(equalToConstant: 40), // 버튼의 높이 설정
        ])
    }
}
