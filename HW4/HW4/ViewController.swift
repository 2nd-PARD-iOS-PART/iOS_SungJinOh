//
//  ViewController.swift
//  HW3
//
//  Created by 오성진 on 9/26/23.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 전체 배경색 black
        view.backgroundColor = .black
        //
//        let tabBarVC = UITabBarController()
        
        //tabBar 총 5개 만들기
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: ComingSoonViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        let vc5 = UINavigationController(rootViewController: MoreViewController())
        
        //navigationController?.navigationBar.isTranslucent = false // navigationBar를 불투명하게 해줌으로써 스크롤되는 내용물이 네비게이션 바 아래로 가려지지 않는다.
        
        //tabBar에 넣을 이미지 삽입
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "search")
        vc3.tabBarItem.image = UIImage(named: "play")
        vc4.tabBarItem.image = UIImage(named: "download")
        vc5.tabBarItem.image = UIImage(named: "more")

        //tabBar 이름들 설정
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Coming Soon"
        vc4.title = "Downloads"
        vc5.title = "More"
         
        //tabBar의 틴트 색상 설정
        //label: 탭바의 라벨 색상과 일치하도록 설정
        tabBar.tintColor = .label
        
        //탭 바 컨트롤러에 총 5개의 뷰 컨트롤러를 설정
        //vc1에서 vc5까지의 뷰 컨트롤러가 배열의 순서대로 탭 바 아이템으로 표시된다.
        //사용자가 탭을 선택하면 해당 뷰 컨트롤러로 전환된다.
        //선택한 탭이 활성화되는 동안 애니메이션 효과가 적용된다.
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
        //tabBar의 배경색: black
        tabBar.backgroundColor = .gray
        
//        present(tabBarVC, animated: true, completion: nil)
        
    }
    
}
