import UIKit

class SearchCollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "SearchCollectionViewTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var imageNames: [String] = ["movie1.png", "movie2.png", "movie3.png", "movie4.png"] // 이미지 파일 이름 배열
    var texts: [String] = ["play"] // 텍스트 배열
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

extension SearchCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // 각 셀 내부의 내용을 수동으로 구현
        let imageName = imageNames[indexPath.row]
        print(imageName)
        // 이미지 뷰
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        // 텍스트 레이블
        let textLabel = UILabel()
        textLabel.text = "play"
        textLabel.textColor = .black
        textLabel.font = UIFont.systemFont(ofSize: 14)
        cell.contentView.addSubview(textLabel)
        
        // 각 요소의 위치와 크기를 조정
        imageView.frame = CGRect(x: 10, y: 10, width: 80, height: 120)
        textLabel.frame = CGRect(x: 10, y: 140, width: 80, height: 20)
        
        return cell
    }
}
