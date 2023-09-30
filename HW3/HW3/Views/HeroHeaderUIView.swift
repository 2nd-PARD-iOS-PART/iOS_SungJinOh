//
//  HeroHeaderUIView.swift
//  HW3
//
//  Created by 오성진 on 9/30/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
//    private func addGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor.clear.cgColor, // clear로 시작했다가
//            UIColor.black.cgColor // 아래로 갈수록 어두워짐
//        ]
//        gradientLayer.frame = bounds
//        layer.addSublayer(gradientLayer)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
//        addGradient()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
