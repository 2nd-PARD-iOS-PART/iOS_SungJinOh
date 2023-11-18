//
//  UpdateViewController.swift
//  URLSession_server
//
//  Created by 김하람 on 2023/11/09.
//

import UIKit

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var updateData: DataList?
    var convertedImgView: String = ""
    
    init(data: DataList) {
        self.updateData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameField = UITextField()
    let ageTextField = UITextField()
    let partTextField = UITextField()
    let imageView = UIImageView()
    let selectImageButton = UIButton(type: .system)
    let submitButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNameField(nameField, text: updateData!.name)
        setupTextField(ageTextField, placeholder: "나이를 입력해주세요", text: "\(updateData!.age)")
        setupTextField(partTextField, placeholder: "파트를 입력해주세요", text: updateData!.part)
        setupImageView()
        setupSelectImageButton()
        setupSubmitButton()
        setupUi()
    }
    
    // Create할 때와 달리, 이름은 Primary Key 이므로 수정을 불가하게 한다.
    func setupNameField(_ textField: UITextField, text: String) {
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false // 사용자가 입력하지 못하도록 한다.
        textField.text = text
        textField.backgroundColor = .systemGray3
        view.addSubview(textField)
    }
    func setupTextField(_ textField: UITextField, placeholder: String, text: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.text = text
        view.addSubview(textField)
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        // 이 부분에서 updateData?.imgURL을 사용하여 URL을 가져오고, 그 URL을 사용하여 이미지를 가져와서 설정
        if let imageUrlString = updateData?.imgURL, let imageUrl = URL(string: imageUrlString) {
            // 이미지를 비동기적으로 가져와서 설정
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        view.addSubview(imageView)
    }

    func setupSelectImageButton() {
        selectImageButton.setTitle("이미지 선택", for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectImageTapped), for: .touchUpInside)
        view.addSubview(selectImageButton)
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("수정하기", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    func setupUi() {
        let sidePadding: CGFloat = 20
        let textFieldHeight: CGFloat = 40
        let imageSize: CGFloat = 200
        nameField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        partTextField.translatesAutoresizingMaskIntoConstraints = false
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Name TextField
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            nameField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            // Age TextField
            ageTextField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            ageTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            // Part TextField
            partTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),
            partTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            partTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            partTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            // Select Image Button
            selectImageButton.topAnchor.constraint(equalTo: partTextField.bottomAnchor, constant: 20),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            selectImageButton.heightAnchor.constraint(equalToConstant: textFieldHeight),
            // Image View
            imageView.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            // Submit Button
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            submitButton.heightAnchor.constraint(equalToConstant: textFieldHeight),
        ])
    }
    
    // MARK: - Create 부분과 굉장히 유사. Create과 다른 부분만 설명할게요 !
    @objc func selectImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let name = updateData!.name
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            uploadImage(image: pickedImage, name: name)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func uploadImage(image: UIImage, name: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image to data")
            return
        }
        let url = URL(string: "http://3.35.236.83/image")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(name).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error uploading image: \(error)")
                return
            }

            if let data = data {
                if let imageURLString = String(data: data, encoding: .utf8) {
                    print("✅ Image uploaded successfully. Image URL: \(imageURLString)")
                    self.convertedImgView = imageURLString
                    NotificationCenter.default.post(name: .addNotification, object: nil)
                    //        dismiss(animated: true)
                } else {
                    print("🚨 Invalid response format. Expected a string.")
                }
            }
        }
        task.resume()
    }

    @objc func submitButtonTapped() {
        guard imageView.image != nil else {
            print("No image selected")
            return
        }
        let name = nameField.text
        let age = ageTextField.text
        let part = partTextField.text
        let intAge = Int(age!)
        
        detailAge.text = "age: \(age ?? "null")"
        detailPart.text = "part: \(part ?? "null")"
        // '수정하기' 버튼 클릭시, 서버에 Update하는 함수 호출하기
        makeUpdateRequest(with: name!, name: name!, age: intAge!, part: part!, imgUrl: convertedImgView)
        dismiss(animated: true)
    }
}
