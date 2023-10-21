import UIKit

class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SearchCollectionViewTableViewCell.self, forCellReuseIdentifier: SearchCollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar()
        
        tableView.register(Democell.self, forCellReuseIdentifier: "cell")
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
        
        // 좌측 이미지 추가
        let leftImageView = UIImageView(image: UIImage(named: "magnifying.png"))
        leftImageView.frame = CGRect(x: 6, y: 11, width: 20, height: 20)
        searchBar.addSubview(leftImageView)
        
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
