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
        view.backgroundColor = .green
        //
//        let tabBarVC = UITabBarController()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: ComingSoonViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        let vc5 = UINavigationController(rootViewController: MoreViewController())
        
        navigationController?.navigationBar.isTranslucent = false

        
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "search")
        vc3.tabBarItem.image = UIImage(named: "play")
        vc4.tabBarItem.image = UIImage(named: "download")
        vc5.tabBarItem.image = UIImage(named: "more")

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Coming Soon"
        vc4.title = "Downloads"
        vc5.title = "More"
        
//        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
         
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        tabBar.backgroundColor = .black
        
//        present(tabBarVC, animated: true, completion: nil)
        
    }
    
}
