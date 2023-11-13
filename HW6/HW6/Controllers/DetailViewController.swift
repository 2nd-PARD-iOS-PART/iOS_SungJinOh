// DetailViewController

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func didUpdateItem()
}

class DetailViewController: UIViewController{

    
    let item: DownloadedItem
    
    init(item: DownloadedItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupUI()

    }
    
    func setupUI() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = item.image {
            imageView.image = UIImage(data: imageData)
        }
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = item.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.text = item.summary
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = 0
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}
