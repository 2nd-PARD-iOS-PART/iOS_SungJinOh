import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell" // 클래스 내에서 사용할 셀 식별자(identifier)를 정의, 셀의 재사용을 관리하고, 셀을 생성하거나 가져올 때 사용된다.

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // 콜렉션 뷰의 레이아웃을 정의하기 위해 UICollectionViewFlowLayout를 생성, 콜렉션 뷰 셀의 크기와 스크롤 방향을 설정하는 데 사용된다.
        layout.itemSize = CGSize(width: 140, height: 200) // 셀의 크기를 설정 (셀의 너비: 140 포인트, 높이: 200 포인트)
        layout.scrollDirection = .horizontal // 스크롤 방향을 수평(horizontal)으로 설정한다. -> 셀들이 좌우로 스크롤되는 수평 스크롤 레이아웃이 만들어진다.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // 위에서 설정한 레이아웃(layout)을 사용하여 콜렉션 뷰(UICollectionView)를 생성한다. frame은 .zero로 설정되어 있으므로 초기에는 콜렉션 뷰의 크기가 없다.
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell") // register(_:forCellReuseIdentifier:) 메서드는, 새로운 셀을 만들 때 사용할 클래스를 "등록" 한다. 콜렉션 뷰에서 사용할 셀의 클래스를 등록, 기본 UICollectionViewCell을 사용하며, "cell" 식별자를 부여한다.
        return collectionView // 초기화된 콜렉션 뷰를 반환
    }()

    // 각 row에 대한 이미지 배열
    var imageNames: [[String]] = [] // 2차원 문자열 배열을 선언, 각 셀에 대한 이미지 이름들을 저장하는 데 사용된다.

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // 초기화 메서드(init)를 재정의(override)한다. 이 메서드는 셀(CollectionViewTableViewCell)을 초기화할 때 호출된다.
        super.init(style: style, reuseIdentifier: reuseIdentifier) // 부모 클래스인 UITableViewCell의 초기화 메서드를 호출한다.
        contentView.backgroundColor = .black // 셀의 contentView의 배경색을 검은색으로 설정한다.
        contentView.addSubview(collectionView) // collectionView을 contentView에 추가한다. 이로써 콜렉션 뷰가 셀 내에 포함되어 화면에 표시된다.

        collectionView.delegate = self
        collectionView.dataSource = self
        // 콜렉션 뷰의 델리게이트(delegate)와 데이터 소스(data source)를 현재 클래스(CollectionViewTableViewCell)로 설정한다. 이렇게 하면 이 클래스 내에서 콜렉션 뷰의 동작을 관리하고 데이터를 제공할 수 있다.

        // 각 row에 대한 이미지 배열 설정
        let previewsImages = ["movie1", "movie2", "movie3", "movie4"]
        let continueWatchingImages = ["movie5", "movie6", "movie7", "movie8"]
        let myListImages = ["movie9", "movie10", "movie11", "movie12"]
        let europeMovieImages = ["movie13", "movie14", "movie15", "movie16"]
        let romanceDramaImages = ["movie17", "movie18", "movie19", "movie20"]
        let actionThrillerImages = ["movie21", "movie22", "movie23", "movie24"]

        // 각 셀에 대한 이미지 배열을 설정
        imageNames = [previewsImages, continueWatchingImages, myListImages, europeMovieImages, romanceDramaImages, actionThrillerImages]

    }

    required init(coder: NSCoder) { // 셀을 초기화하는 데 필요한 이니셜라이저를 구현하거나, 해당 이니셜라이저를 사용하지 않도록 하기 위해 에러를 발생시킨다.
        fatalError() // 프로그램 실행 시 에러를 발생시킨다 ???
    }

    override func layoutSubviews() { // 셀의 하위 뷰들의 레이아웃을 업데이트하여 콜렉션 뷰를 셀 내에 맞게 배치한다. 이 메서드는 셀의 크기나 레이아웃이 변경될 때 호출된다.
        super.layoutSubviews()
        collectionView.frame = contentView.bounds // 콜렉션 뷰(collectionView)의 프레임을 셀의 contentView의 경계(bounds)에 맞게 설정한다. -> 콜렉션 뷰가 셀 내에 전체 영역을 차지하게 된다.
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource { // CollectionViewTableViewCell 클래스를 확장(extension)하여 UICollectionViewDelegate와 UICollectionViewDataSource 프로토콜을 채택한다.

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        // 셀에서 imageView를 찾거나 없으면 새롭게 만든다.
        let imageView: UIImageView

        if let existingImageView = cell.contentView.subviews.compactMap({ $0 as? UIImageView }).first {
            imageView = existingImageView
        } else {
            imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imageView)
        }

        let image = UIImage(named: imageNames[indexPath.section][indexPath.item])
        imageView.image = image

        imageView.frame = cell.contentView.bounds

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // 각 섹션에는 4개의 이미지가 있어야 한다.
    }
}
