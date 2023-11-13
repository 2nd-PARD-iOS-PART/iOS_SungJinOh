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
    
    var imageNames: [String] = []
    
    
    //error: "Cannot find 'modalViewController' in scope" 발생 시
    private var modalViewController: UIViewController?
    
    // "Episodes" button 토글 클릭 시
    @objc func episodesButtonTapped() {
    }

    // "Collection" button 토글 클릭 시
    @objc func collectionButtonTapped() {
    }
    
    // "More Like This" button 토글 클릭 시
    @objc func moreLikeThisButtonTapped() {
    }

    // "Trailers&More" button 토글 클릭 시
    @objc func trailersButtonTapped() {
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        
        // image들 사이를 까맣게 채워주는 코드... 이거였구나... 겨우 찾았네
        collectionView.backgroundColor = .black
        
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) { // 셀을 초기화하는 데 필요한 이니셜라이저를 구현하거나, 해당 이니셜라이저를 사용하지 않도록 하기 위해 에러를 발생시킨다.
        //fatalError() // 프로그램 실행 시 에러를 발생시킨다 ???
        super.init(coder: coder) // fatalError() 대신 nil을 반환하도록 수정
    }

    override func layoutSubviews() { // 셀의 하위 뷰들의 레이아웃을 업데이트하여 콜렉션 뷰를 셀 내에 맞게 배치한다. 이 메서드는 셀의 크기나 레이아웃이 변경될 때 호출된다.
        super.layoutSubviews()
        collectionView.frame = contentView.bounds // 콜렉션 뷰(collectionView)의 프레임을 셀의 contentView의 경계(bounds)에 맞게 설정한다. -> 콜렉션 뷰가 셀 내에 전체 영역을 차지하게 된다.
    }
    
}

// modal page 구성
extension CollectionViewTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
                
                // 영화 제목을 MovieDetail model에서 가져오기
                if let title = MovieDetail.titles[imageName] {
                    seriesLabel.text = title
                } else {
                    seriesLabel.text = "Default Title"
                }
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

                // 상세 설명을 MovieDetail model에서 가져오기
                if let detail = MovieDetail.details[imageName] {
                    seriesDetail.text = detail
                } else {
                    seriesDetail.text = "Default Detail"
                }
                seriesDetail.textColor = .white
                seriesDetail.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                modalViewController.view.addSubview(seriesDetail)
                
                // MyList image 추가
                let mylistImage = UIImageView(frame: CGRect(x: 20, y: 510, width: 70, height: 70))
                mylistImage.image = UIImage(named: "mylist.png")
                modalViewController.view.addSubview(mylistImage)
                
                // Rate image 추가
                let rateImage = UIImageView(frame: CGRect(x: 130, y: 510, width: 70, height: 70))
                rateImage.image = UIImage(named: "rate.png")
                modalViewController.view.addSubview(rateImage)
                
                // Share image 추가
                let shareImage = UIImageView(frame: CGRect(x: 240, y: 510, width: 70, height: 70))
                shareImage.image = UIImage(named: "share.png")
                modalViewController.view.addSubview(shareImage)
                
                
                // Add buttons for toggle behavior
                let episodesButton = UIButton(frame: CGRect(x: 0, y: 600, width: 80, height: 30))
                episodesButton.setTitle("Episodes", for: .normal)
                episodesButton.addTarget(self, action: #selector(episodesButtonTapped), for: .touchUpInside)
                modalViewController.view.addSubview(episodesButton)

                let collectionButton = UIButton(frame: CGRect(x: 90, y: 600, width: 100, height: 30))
                collectionButton.setTitle("Collection", for: .normal)
                collectionButton.addTarget(self, action: #selector(collectionButtonTapped), for: .touchUpInside)
                modalViewController.view.addSubview(collectionButton)

                let moreLikeThisButton = UIButton(frame: CGRect(x: 200, y: 600, width:100, height: 30))
                moreLikeThisButton.setTitle("More Like This", for: .normal)
                moreLikeThisButton.addTarget(self, action: #selector(moreLikeThisButtonTapped), for: .touchUpInside)
                modalViewController.view.addSubview(moreLikeThisButton)

                let trailersButton = UIButton(frame: CGRect(x: 310, y: 600, width: 100, height: 30))
                trailersButton.setTitle("Trailers&More", for: .normal)
                trailersButton.addTarget(self, action: #selector(trailersButtonTapped), for: .touchUpInside)
                modalViewController.view.addSubview(trailersButton)
                
                viewController.present(modalViewController, animated: true, completion: nil)
            }
        }

    @objc func dismissModal() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }

}



extension CollectionViewTableViewCell: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count // 배열의 image의 개수 return
    }

    // UICollectionViewDataSource 프로토콜의 일부
    // 컬렉션 뷰의 셀을 구성하고 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit // 이미지의 가로, 세로 비율을 유지
        imageView.image = UIImage(named: imageNames[indexPath.row]) // indexPath.row를 기반으로 imageNames 배열에서 가져와진 image가 표시된다.
        cell.contentView.addSubview(imageView)
        
        return cell
    }
}

