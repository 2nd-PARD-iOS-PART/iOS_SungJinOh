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
        contentView.backgroundColor = .blue // 셀의 contentView의 배경색을 검은색으로 설정한다.
        contentView.addSubview(collectionView) // collectionView을 contentView에 추가한다. 이로써 콜렉션 뷰가 셀 내에 포함되어 화면에 표시된다.

        collectionView.delegate = self
        collectionView.dataSource = self
        // 콜렉션 뷰의 델리게이트(delegate)와 데이터 소스(data source)를 현재 클래스(CollectionViewTableViewCell)로 설정한다. 이렇게 하면 이 클래스 내에서 콜렉션 뷰의 동작을 관리하고 데이터를 제공할 수 있다.

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) // 재사용 가능한 셀을 가져오거나 생성한다. "cell" 식별자를 사용하여 셀을 생성하거나 재사용한다.

        // Load the image corresponding to the current index from the array
        // indexPath: 현재 셀의 섹션과 항목
        if indexPath.section < imageNames.count && indexPath.item < imageNames[indexPath.section].count { // 현재 indexPath를 사용하여 현재 셀에 대한 이미지를 가져오기 전에 유효성을 검사한다.
            if let image = UIImage(named: imageNames[indexPath.section][indexPath.item]) { // 이미지 이름을 사용하여 UIImage를 로드한다. imageNames 배열에서 indexPath.section은 섹션을, indexPath.item은 해당 섹션에서의 항목(셀)을 나타냅니다. 로드된 이미지는 image 상수에 할당된다.
                let imageView = UIImageView(image: image) // 로드한 이미지를 표시하기 위해 UIImageView를 생성하고 image를 설정한다.
                imageView.contentMode = .scaleAspectFill // 이미지를 셀의 경계에 맞게 확대 또는 축소하고, 잘라내어 셀에 가득 채우는 역할을 한다.
                imageView.frame = cell.contentView.bounds // imageView의 프레임을 셀의 contentView의 경계에 맞게 설정합니다. -> 이미지 뷰가 셀 내에 가득 표시된다.

                cell.contentView.subviews.forEach { $0.removeFromSuperview() } // 셀의 contentView에 있는 기존 서브뷰(이미지 뷰)를 모두 제거한다. 이전에 셀에 추가된 다른 서브뷰를 모두 삭제하고 새로운 이미지 뷰만 남겨둔다. -> 이전 이미지가 셀에 겹치거나 중첩되지 않는다.

                cell.contentView.addSubview(imageView) // 새로 생성한 이미지 뷰(imageView)를 셀의 contentView에 추가한다. -> 현재 셀에 해당하는 이미지가 셀 내에 표시된다.
            }
        }

        return cell // 최종적으로 구성된 셀을 반환
    }

    
    // 아래의  두 메서드를 통해 콜렉션 뷰는 각 섹션에 대한 셀의 수와 전체 섹션의 수를 알 수 있으며, 이 정보를 기반으로 데이터를 표시하고 레이아웃을 구성한다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // 이 메서드는 현재 섹션(section)에 대한 셀의 개수를 반환한다. 파라미터로 받은 section 매개변수는 현재 섹션의 인덱스를 나타낸다.
        if section < imageNames.count { // 현재 섹션 인덱스가 imageNames 배열의 유효한 인덱스 범위 내에 있는지 확인한다. 이렇게 하는 이유는 셀의 수를 반환하기 전에 해당 섹션이 유효한지 확인하기 위해서이다.
            return imageNames[section].count // 현재 섹션의 이미지 이름 배열(imageNames[section])에 포함된 이미지의 개수를 반환한다. 이것이 해당 섹션에 대한 셀의 개수가 된다.
        }
        return 0 // 섹션 인덱스가 유효한 범위 내에 없는 경우, 해당 섹션에는 셀이 없으므로 0을 반환한다.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int { // 이 메서드는 콜렉션 뷰에 표시할 섹션의 개수를 반환한다. 이 메서드는 전체 섹션의 개수를 결정한다.
        // Return the number of rows
        return imageNames.count // imageNames 배열의 길이(즉, 섹션의 수)를 반환한다. 이것이 전체 섹션의 개수가 된댜.
    }
}
