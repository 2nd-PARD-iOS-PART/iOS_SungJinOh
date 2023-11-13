//
//  Data.swift
//  HW6
//
//  Created by 오성진 on 11/7/23.
//

import Foundation
import RealmSwift

class DownloadedItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var image: Data? // Store image as Data in Realm
}


/*
 func (_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let imageName = imageNames[indexPath.item]
         print(imageName)
         
         if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let viewController = windowScene.windows.first?.rootViewController {
             let modalViewController = UIViewController()
             modalViewController.view.backgroundColor = .black
             
             //상단의 movie image
             let imageView = UIImageView(frame: CGRect(x: 0, y: -50, width: 393, height: 300))
             imageView.image = UIImage(named: imageName)
             modalViewController.view.addSubview(imageView)
             
             // 우상단의 Close Button
             let closeButton = UIButton(frame: CGRect(x: modalViewController.view.bounds.width - 50, y: 20, width: 30, height: 30))
             closeButton.setImage(UIImage(named: "closebutton.png"), for: .normal)
             closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
             modalViewController.view.addSubview(closeButton)
             
             // 우상단의 global icon
             let globalImage = UIImageView(frame: CGRect(x: modalViewController.view.bounds.width - 100, y: 20, width: 30, height: 30))
             globalImage.image = UIImage(named: "videocontrol.png")
             modalViewController.view.addSubview(globalImage)
             
             // 상단 이미지의 재생 버튼
             let playImage = UIImage(named: "play-large")
             let playImageView = UIImageView(image: playImage)
             playImageView.contentMode = .scaleAspectFit
             playImageView.translatesAutoresizingMaskIntoConstraints = false
             modalViewController.view.addSubview(playImageView)
             NSLayoutConstraint.activate([
                 playImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                 playImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
             ])
             
             // N series image
             let seriesImage = UIImageView(frame: CGRect(x: 3, y: 260, width: 80, height: 20))
             seriesImage.image = UIImage(named: "Nseries.png")
             modalViewController.view.addSubview(seriesImage)
             
             // movie title
             let seriesLabel = UILabel(frame: CGRect(x: 0, y: 280, width: 200, height: 30))
             //seriesLabel.text = ""
             
             // click 한 cell의 title
             let seriesLabel = // click 한 cell의 title
             seriesLabel.textColor = .white
             seriesLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
             modalViewController.view.addSubview(seriesLabel)
             
             // metadata image 추가
             let metadata = UIImageView(frame: CGRect(x: 0, y: 320, width: 300, height: 20))
             metadata.image = UIImage(named: "metadata.png")
             modalViewController.view.addSubview(metadata)
             
             // play button 생성
             let playbutton = UIButton(type: .system)
             let playbuttonImage = UIImage(named: "playmodal.png")
             playbutton.setImage(playbuttonImage, for: .normal)
             playbutton.setTitle("play", for: .normal)
             playbutton.setTitleColor(.black, for: .normal)
             playbutton.backgroundColor = .white
             playbutton.titleLabel?.font = playbutton.titleLabel?.font.withSize(20)
             playbutton.layer.cornerRadius = 5
             playbutton.frame = CGRect(x: 0, y: 350, width: 380, height: 40)
             modalViewController.view.addSubview(playbutton)
             
             // download button 생성
             let downloadbutton = UIButton(type: .system)
             let downloadbuttonImage = UIImage(named: "downloadmodal.png")
             downloadbutton.setImage(downloadbuttonImage, for: .normal)
             downloadbutton.setTitle("Download", for: .normal)
             downloadbutton.setTitleColor(.black, for: .normal)
             downloadbutton.backgroundColor = .gray
             downloadbutton.titleLabel?.font = downloadbutton.titleLabel?.font.withSize(18)
             downloadbutton.layer.cornerRadius = 5
             downloadbutton.frame = CGRect(x: 0, y: 400, width: 380, height: 40)
             modalViewController.view.addSubview(downloadbutton)
             
             // movie detail description
             let seriesDetail = UILabel(frame: CGRect(x: 0, y: 450, width: 390, height: 30))
             //seriesLabel.text = ""

             let seriesDetail = // click한 cell의 summary
             seriesDetail.textColor = .white
             seriesDetail.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
             modalViewController.view.addSubview(seriesDetail)


             
             viewController.present(modalViewController, animated: true, completion: nil)
         }
     }

 @objc func dismissModal() {
     if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let viewController = windowScene.windows.first?.rootViewController {
         viewController.dismiss(animated: true, completion: nil)
     }
 }
 */
