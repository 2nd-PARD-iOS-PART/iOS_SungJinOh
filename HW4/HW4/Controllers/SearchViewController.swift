import UIKit

class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SearchCollectionViewTableViewCell.self, forCellReuseIdentifier: SearchCollectionViewTableViewCell.identifier)
        return table
    }()
    
    let images: [String] = ["movie1.png", "movie2.png", "movie3.png", "movie4.png", "movie5.png", "movie6.png", "movie7.png", "movie8.png", "movie9.png", "movie10.png"]
    let texts: [String] = ["슈츠", "이터널 선샤인", "슬기로운 의사생활", "마음의 소리", "여신강림", "알고있지만", "피아니스트", "기생충", "허트로커", "서른, 아홉"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar()
    }

    private func configureNavBar() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        
        // Search Bar 구현
        let searchBar = UISearchBar(frame: CGRect(x: -10, y: 0, width: 380, height: 45))
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search for a show, movies, genre, etc"
        
        searchBar.barTintColor = .gray
        searchBar.backgroundColor = .gray
        
        searchBar.layer.cornerRadius = 10
        
        // 우측 이미지 추가
        let rightImageView = UIImageView(image: UIImage(named: "mic.png"))
        rightImageView.frame = CGRect(x: searchBar.frame.width - 30, y: 10, width: 20, height: 20)
        searchBar.addSubview(rightImageView)
        
        titleView.addSubview(searchBar)
        navigationItem.titleView = titleView
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCollectionViewTableViewCell.identifier, for: indexPath) as? SearchCollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .black
        //cell의 background color을 black으로
        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })
        
        // 해당 행에 대한 이미지 파일 이름 가져오기
        let imageName = images[indexPath.row]
        
        // 이미지 뷰 추가
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 130)
        cell.contentView.addSubview(imageView)
        
        // 텍스트 추가
        let textLabel = UILabel(frame: CGRect(x: 120, y: 50, width: 200, height: 30))
        textLabel.text = texts[indexPath.row]
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        cell.contentView.addSubview(textLabel)
        
        let playButtonImageView = UIImageView(image: UIImage(named: "playbutton.png"))
        playButtonImageView.frame = CGRect(x: cell.contentView.frame.width - 40, y: 60, width: 30, height: 30)
        cell.contentView.addSubview(playButtonImageView)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        
        let label = UILabel()
        label.text = "Popular Searches"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.frame = CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: 80)
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
}
    
    
    //import UIKit
    //
    //class SearchViewController: UIViewController {
    //
    //    private let tableView: UITableView = {
    //        let table = UITableView(frame: .zero, style: .grouped)
    //        table.register(SearchCollectionViewTableViewCell.self, forCellReuseIdentifier: SearchCollectionViewTableViewCell.identifier)
    //        return table
    //    }()
    //
    //    let images: [String] = ["movie1.png", "movie2.png", "movie3.png", "movie4.png", "movie5.png", "movie6.png", "movie7.png", "movie8.png", "movie9.png", "movie10.png"]
    //    let texts: [String] = ["슈츠", "경이로운 소문 2", "슬기로운 의사생활", "마음의 소리", "여신강림", "알고있지만", "피아니스트", "기생충", "허트로커", "서른, 아홉"]
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .systemBackground
    //        tableView.backgroundColor = .black
    //        view.addSubview(tableView)
    //
    //
    //        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    //
    //        // Search Bar 구현
    //        let searchBar = UISearchBar(frame: CGRect(x: -10, y: 0, width: 380, height: 45))
    //        searchBar.searchBarStyle = .prominent
    //        searchBar.placeholder = "Search for a show, movies, genre, etc"
    //
    //        searchBar.barTintColor = .gray
    //        searchBar.backgroundColor = .gray
    //
    //
    //        navigationItem.titleView = searchBar
    //
    //        let rightImageView = UIImageView(image: UIImage(named: "mic.png"))
    //        rightImageView.frame = CGRect(x: searchBar.frame.width - 30, y: 10, width: 20, height: 20)
    //        searchBar.addSubview(rightImageView)
    //
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //    }
    //
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        tableView.frame = view.bounds
    //    }
    //}
    //
    //extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    //
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 10
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCollectionViewTableViewCell.identifier, for: indexPath) as? SearchCollectionViewTableViewCell else {
    //        return UITableViewCell()
    //    }
    //        cell.backgroundColor = .black
    //        //cell의 background color을 black으로
    //        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })
    //
    //        // 해당 행에 대한 이미지 파일 이름 가져오기
    //        let imageName = images[indexPath.row]
    //
    //        // 이미지 뷰 추가
    //        let imageView = UIImageView(image: UIImage(named: imageName))
    //        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 130)
    //        cell.contentView.addSubview(imageView)
    //
    //        // 텍스트 추가
    //        let textLabel = UILabel(frame: CGRect(x: 120, y: 50, width: 200, height: 30))
    //        textLabel.text = texts[indexPath.row]
    //        textLabel.textColor = .white
    //        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
    //        cell.contentView.addSubview(textLabel)
    //
    //        let playButtonImageView = UIImageView(image: UIImage(named: "playbutton.png"))
    //        playButtonImageView.frame = CGRect(x: cell.contentView.frame.width - 40, y: 60, width: 30, height: 30)
    //        cell.contentView.addSubview(playButtonImageView)
    //
    //        return cell
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 130
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView()
    //        headerView.backgroundColor = .black
    //
    //        let label = UILabel()
    //        label.text = "Popular Searches"
    //        label.textColor = .white
    //        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    //        label.frame = CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: 70)
    //
    //        headerView.addSubview(label)
    //
    //        return headerView
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 70
    //    }
    //}

