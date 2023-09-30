//
//  HomeViewController.swift
//  HW3
//
//  Created by 오성진 on 9/29/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    let sectionTitles: [String] = ["Previews", "Continue Watching for Eron", "My List", "Europe Movie", "Romance/Drama", "Action/Thriller"]
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self,  forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    let imageNamesForPreviews = ["movie1", "movie2", "movie3", "movie4"]
    let imageNamesForContinueWatching = ["movie4", "movie3", "movie2", "movie1"]
    let imageNamesForMyList = ["movie1", "movie2", "movie4", "movie3"]
    let imageNamesForEuropeMovie = ["movie2", "movie1", "movie3", "movie4"]
    let imageNamesForRomanceDrama = ["movie3", "movie1", "movie4", "movie2"]
    let imageNamesForActionThriller = ["movie4", "movie3", "movie2", "movie1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        tableView.tableHeaderView = headerView
    }
    
    
//    private func configureNavBar() {
//        var image = UIImage(named: "netflix") // 이미지 이름을 "Netflix"로 수정
//        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
//    }
    
    private func configureNavBar() {
        // Create a custom title view with labels
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

//        // Add the Netflix logo image
//        let netflixLogoImageView = UIImageView(image: UIImage(named: "netflix"))
//        netflixLogoImageView.contentMode = .scaleAspectFit
//        netflixLogoImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
//        titleView.addSubview(netflixLogoImageView)
        
        var image = UIImage(named: "netflix") // 이미지 이름을 "Netflix"로 수정
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)

        // Add "TV Shows" label next to the Netflix logo
        let tvShowsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        tvShowsLabel.text = "TV Shows"
        tvShowsLabel.textColor = .white
        tvShowsLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(tvShowsLabel)

        // Add "Movies" label next to the "TV Shows" label
        let moviesLabel = UILabel(frame: CGRect(x: 100, y: 0, width: 60, height: 44))
        moviesLabel.text = "Movies"
        moviesLabel.textColor = .white
        moviesLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(moviesLabel)
        
        let myListLabel = UILabel(frame: CGRect(x: 190, y: 0, width: 60, height: 44))
        myListLabel.text = "My List"
        myListLabel.textColor = .white
        myListLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(myListLabel)

        // Set the custom title view as the navigation title
        navigationItem.titleView = titleView
    }



    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black // Set the background color
        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.textColor = .white // Set the text color to white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.frame = CGRect(x: 20, y: 0, width: tableView.frame.width - 20, height: 40)
        
        label.frame = CGRect(x: view.safeAreaInsets.left, y: 0, width: tableView.frame.width - (view.safeAreaInsets.left + 20), height: 40)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
}
