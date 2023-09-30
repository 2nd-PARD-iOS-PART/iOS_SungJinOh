//
//  CollectionViewTableViewCell.swift
//  HW3
//
//  Created by 오성진 on 9/29/23.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    // 각 row에 대한 이미지 배열
    var imageNames: [[String]] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        // 각 row에 대한 이미지 배열 설정
        let previewsImages = ["movie1", "movie2", "movie3", "movie4"]
        let continueWatchingImages = ["movie4", "movie3", "movie2", "movie1"]
        let myListImages = ["movie1", "movie2", "movie4", "movie3"]
        let europeMovieImages = ["movie2", "movie1", "movie3", "movie4"]
        let romanceDramaImages = ["movie3", "movie1", "movie4", "movie2"]
        let actionThrillerImages = ["movie4", "movie3", "movie2", "movie1"]

        // 각 셀에 대한 이미지 배열을 설정
        imageNames.append(previewsImages)
        imageNames.append(continueWatchingImages)
        imageNames.append(myListImages)
        imageNames.append(europeMovieImages)
        imageNames.append(romanceDramaImages)
        imageNames.append(actionThrillerImages)
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        // Load the image corresponding to the current index from the array
        if indexPath.section < imageNames.count && indexPath.item < imageNames[indexPath.section].count {
            if let image = UIImage(named: imageNames[indexPath.section][indexPath.item]) {
                // Set the background of the cell to the loaded image
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                imageView.frame = cell.contentView.bounds

                // Remove any existing subviews from the cell
                cell.contentView.subviews.forEach { $0.removeFromSuperview() }

                cell.contentView.addSubview(imageView)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of images for the current row (section)
        if section < imageNames.count {
            return imageNames[section].count
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of rows
        return imageNames.count
    }
}
