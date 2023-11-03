import UIKit

class MovieDetailViewController: UIViewController {
    private let movieName: String

    // 이미지를 표시하기 위한 UIImageView 추가
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(movieName: String) {
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 이미지 뷰를 화면에 추가
        view.addSubview(movieImageView)

        // 이미지 뷰의 제약 조건을 설정하여 화면 상단에 위치하도록 함
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])

        // 영화 이미지 설정
        movieImageView.image = UIImage(named: movieName)
    }
}
