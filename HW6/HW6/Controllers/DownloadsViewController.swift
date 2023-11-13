////
//  DownloadsViewController.swift
//  HW3
//
//  Created by 오성진 on 9/29/23.
//

import UIKit
import RealmSwift

let realm = try! Realm() // realm instance 생성

var info: [DownloadedItem] = []
var selectedindex : IndexPath?


class DownloadsViewController: UIViewController, AddMovieViewControllerDelegate {
    
    var isEditingMode = false
    
    let tableView: UITableView = { // tableView라는 UITableView 인스턴스를 선언
        let table = UITableView() //UITableView를 생성
        table.translatesAutoresizingMaskIntoConstraints = false // 해당 테이블 뷰의 오토레이아웃을 비활성화
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 셀 등록
        return table
    }() // tableView를 상수로 초기화하기 위해 클로저를 호출
    
    let downloadTitle : UILabel = {
        let label = UILabel()
        label.text = "Download"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // Set this to false to enable auto layout for the label
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    let deleteButton : UIButton = {
        var deleteButton = UIButton(type: .system)
        var deleteImage = UIImage(named: "delete.png")
        deleteImage = deleteImage?.withRenderingMode(.alwaysOriginal)
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return deleteButton
    }()
    
    let downloadImage : UIImageView = {
        // 이미지 뷰 생성 및 설정
        let imageView = UIImageView(image: UIImage(named: "downloadbutton.png"))
        imageView.contentMode = .center // 이미지를 중앙에 맞추도록 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let downloadLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Movies and TV shows that you\ndownload appear here."
        textLabel.textColor = .gray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2 // 여러 줄로 표시하도록 설정
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let downloadButton : UIButton = {
        // 버튼 생성 및 설정
        let button = UIButton(type: .system)
        button.setTitle("Find Something to Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // tableview 관련 설정
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // custom UITableViewCell
        //
        
//        tableView.isEditing = true

        // 뷰 계층에 추가
        view.addSubview(downloadTitle)
        view.addSubview(downloadImage)
        view.addSubview(downloadLabel)
        view.addSubview(downloadButton)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        
        // click 시 이동
        downloadButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        let addButton = UIBarButtonItem(image: UIImage(named: "add.png")?.withRenderingMode(.alwaysOriginal),
                                                style: .plain, target: self, action: #selector(add))
                
        let deleteButton = UIBarButtonItem(image: UIImage(named: "delete.png")?.withRenderingMode(.alwaysOriginal),
                                                   style: .plain, target: self, action: #selector(toggleEditing))
                
        navigationItem.rightBarButtonItems = [deleteButton, addButton]

        addConstraints()
        
    }

    @objc func toggleEditing() {
        isEditingMode.toggle()
        tableView.setEditing(isEditingMode, animated: true)
    }

    
    func addConstraints() {
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            
            downloadTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            downloadTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            
            downloadImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            downloadLabel.topAnchor.constraint(equalTo: downloadImage.bottomAnchor, constant: 20),
            downloadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: downloadTitle.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            
            downloadButton.topAnchor.constraint(equalTo: downloadLabel.bottomAnchor, constant: 230),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 270), // 버튼의 폭 설정
            downloadButton.heightAnchor.constraint(equalToConstant: 40), // 버튼의 높이 설정
            
        ])
    }
    
    // data 추가
    @objc func add() {
        print("Add button pressed")

        let addMovieVC = AddMovieViewController()
        addMovieVC.delegate = self // Set the delegate
        present(addMovieVC, animated: true, completion: nil)
    }

//
//    @objc func addButtonPressed() {
//        let addMovieVC = AddMovieViewController()
//        present(addMovieVC, animated: true, completion: nil)
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func didSaveItem() {
        tableView.reloadData()
    }

}



extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = realm.objects(DownloadedItem.self)
        return items.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .darkGray
        
        let items = realm.objects(DownloadedItem.self)
        let item = items[indexPath.row]
        
        // Create an image view
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = item.image {
            imageView.image = UIImage(data: imageData)
        }
        
        // Create a label for the title
        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a label for the summary
        let summaryLabel = UILabel()
        summaryLabel.text = item.summary
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = 0
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Remove previous constraints and subviews
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Add new subviews
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(titleLabel)
        cell.contentView.addSubview(summaryLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Image view constraints
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Title label constraints
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
            
            // Summary label constraints
            summaryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            summaryLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
            summaryLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
        ])
        
        return cell
    }
    
    // cell click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            // Handle cell selection logic for editing mode
            if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
                print("Selected Index Paths: \(selectedIndexPaths)")
            }
        } else {
            // Handle cell selection logic for normal mode
            print(indexPath)
            selectedindex = indexPath

            // Get the selected item from the realm
            let items = realm.objects(DownloadedItem.self)
            let selectedItem = items[indexPath.row]

            let detailViewController = DetailViewController(item: selectedItem)
            present(detailViewController, animated: true, completion: nil)
        }
    }

    // cell 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let items = realm.objects(DownloadedItem.self)
            let infoToDelete = items[indexPath.row]
            do {
                try realm.write {
                    realm.delete(infoToDelete)
                }

                // Update your data source and table view
                info = Array(items) // Update the info array
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch let error {
                print("Error deleting from Realm: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

// AddMovieViewController

protocol AddMovieViewControllerDelegate: AnyObject {
    func didSaveItem()
}

class AddMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: AddMovieViewControllerDelegate?


    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "영화 제목"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let summaryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "영화 줄거리"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미지 선택", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saveButton : UIButton = {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()

    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleTextField)
        view.addSubview(summaryTextField)
        view.addSubview(addImageButton)
        view.addSubview(saveButton)

        addConstraints()

        saveButton.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)

        addImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            // titleTextField constraints
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // summaryTextField constraints
            summaryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            summaryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // addImageButton constraints
            addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addImageButton.topAnchor.constraint(equalTo: summaryTextField.bottomAnchor, constant: 50),
            
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }

    // image 고르기
    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

    // imagePicker 코드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // realm에 저장
    @objc func saveToRealm() {
        guard
            let title = titleTextField.text,
            let summary = summaryTextField.text,
            let image = selectedImage
        else {
            print("⚠️ Somthing missed")
            return
        }

        let newInfo = DownloadedItem()
        newInfo.title = title
        newInfo.summary = summary
        newInfo.image = image.pngData()

        do {
            try realm.write {
                realm.add(newInfo)
                print("Data saved to Realm:")
                let items = realm.objects(DownloadedItem.self)
                print("Number of items in Realm: \(items.count)")
                for item in items {
                    print("Title: \(item.title), Summary: \(item.summary), Image: \(String(describing: item.image))")
                }
            }
            
            delegate?.didSaveItem() // Notify the delegate that an item is saved
            
            dismiss(animated: true, completion: nil) // Dismiss the AddMovieViewController
            
        } catch let error {
            print("⚠️ Error saving to Realm: \(error)")
        }
    }
    
}
