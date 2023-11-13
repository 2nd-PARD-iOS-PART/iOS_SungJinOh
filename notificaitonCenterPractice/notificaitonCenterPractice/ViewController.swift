//
//  ViewController.swift
//  notificaitonCenterPractice
//
//  Created by 오성진 on 11/4/23.
//

import UIKit

extension Notification.Name {
    static let myNotification = Notification.Name("myNotification")
}

class ViewController: UIViewController {
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "press"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        return lbl
    }()
    
    let button: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 40))
        btn.setTitle("Button" ,for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(openModal), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(button)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .myNotification, object: nil)
    }
    
    @objc func buttonPressed() {
        NotificationCenter.default.post(name: .myNotification, object: nil)
        print("bb")
    }
    
    // #selector와 @objc는 항상 붙어다닌다
    @objc func handleNotification() {
        label.text = "Notification 받음"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

//    @objc func openNavigation() {
//        let secondVC = SecondViewNavigationController()
//        self.navigationController?.pushViewController(secondVC, animated: true)
//    }
    
    @objc func openModal() {
        let secondVC = SecondViewController()
        let navController = UINavigationController(rootViewController: secondVC)
        self.present(navController, animated: true, completion: nil)
    }
}

