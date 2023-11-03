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
        
        tableView.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height - 120)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    
    // NavigationBar
    private func naviBar(){
        let naviBar = UINavigationBar(frame: CGRect(x: 0, y:60, width: view.frame.size.width, height: 60))
        naviBar.barTintColor = .black
        naviBar.tintColor = .white

        // 네비게이션 바 아이템 설정
        let naviItem = UINavigationItem()
        
        // image 설정
        let imageView = UIImageView(image: UIImage(named: "notification.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        // title 설정
        let title = UILabel()
        title.text = "Notification"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        // image와 title을 UIBarButtonItem로 래핑했다.
        let imageItem = UIBarButtonItem(customView: imageView)
        let titleItem = UIBarButtonItem(customView: title)
        
        // 네비게이션 아이템에 이미지와 텍스트 바 버튼을 추가
        naviItem.leftBarButtonItems = [imageItem, titleItem]
        
        naviBar.items = [naviItem]

        view.addSubview(naviBar)
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
    
//      let imageView = UIImageView(image: UIImage(named: "movie1.png"))
        
        let imageName = imageNames[indexPath.row % imageNames.count]
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 10, y: 10, width: 120, height: 80)
        cell.addSubview(imageView)
        
        let detailLabel = UILabel()
        detailLabel.text = detail[indexPath.row % detail.count]
        detailLabel.textColor = .white
        detailLabel.numberOfLines = 3 // 3줄 생성
        detailLabel.frame = CGRect(x: 150, y: 10, width: 120, height: 80)
        cell.addSubview(detailLabel)
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
