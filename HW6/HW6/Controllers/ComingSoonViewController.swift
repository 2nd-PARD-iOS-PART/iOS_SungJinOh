//
//  ComingSoonViewController.swift
//  HW3
//
//  Created by 오성진 on 9/29/23.
//

import UIKit

class ComingSoonViewController: UIViewController {
    
    private let tableView = UITableView()
    
    // 이미지 파일 이름을 담은 배열 생성
    let imageNames = ["NewArrival1.png", "NewArrival2.png", "NewArrival3.png"]
    
    // 각 셀의 설명을 담은 배열 생성
    let detail = ["New Arrival\nEl Chapo 4\nOct 31", "New Arrival\nPeaky Blinders 5\nNov 1", "New Arrival\nVenom 3\nNov 2"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor  = .black
        
        naviBar()
        settingTableView()
        
    }
    
    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Auto Layout constraints 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // NavigationBar
    private func naviBar(){
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.barTintColor = .black
        naviBar.tintColor = .white
        
        view.addSubview(naviBar)
        
        // Auto Layout constraints 설정
        NSLayoutConstraint.activate([
            naviBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            naviBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            naviBar.heightAnchor.constraint(equalToConstant: 60)
        ])

        // 네비게이션 바 아이템 설정
        let naviItem = UINavigationItem()
        
        // image 설정
        let imageView = UIImageView(image: UIImage(named: "notification.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // title 설정
        let title = UILabel()
        title.text = "Notification"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        // image와 title을 UIBarButtonItem로 래핑했다.
        let imageItem = UIBarButtonItem(customView: imageView)
        let titleItem = UIBarButtonItem(customView: title)
        
        // 네비게이션 아이템에 이미지와 텍스트 바 버튼을 추가
        naviItem.leftBarButtonItems = [imageItem, titleItem]
        naviBar.items = [naviItem]
    }
}

extension ComingSoonViewController: UITableViewDelegate, UITableViewDataSource{
    
    // 테이블 뷰 데이터 소스 메서드 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3 // 2개의 셀을 반환
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .darkGray // 셀 배경색 설정
        
        let imageName = imageNames[indexPath.row % imageNames.count]
        let image = UIImage(named: imageName)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(imageView)
        
        let detailLabel = UILabel()
        detailLabel.text = detail[indexPath.row % detail.count]
        detailLabel.textColor = .white
        detailLabel.numberOfLines = 3 // 3줄 생성
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(detailLabel)
        
        // Auto Layout constraints 설정
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            detailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            detailLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            detailLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
            detailLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -10)
        ])
        
        return cell
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
