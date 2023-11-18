//
//  Create.swift
//  URLSession_server
//
//  Created by 김하람 on 2023/11/08.
//

import UIKit
import Photos

// 데이터 추가 후 화면을 다시 그리기 위한 Notification 생성하기
extension Notification.Name {
    static let addNotification = Notification.Name("addNotification")
}

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let nameTextField = UITextField()
    let ageTextField = UITextField()
    let partTextField = UITextField()
    let imageView = UIImageView()
    let selectImageButton = UIButton(type: .system)
    let submitButton = UIButton(type: .system)
    var convertedImgView : String = ""
    
    // MARK: - Ui 설정하기
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextField(nameTextField, placeholder: "이름을 입력해주세요")
        setupTextField(ageTextField, placeholder: "나이를 입력해주세요")
        setupTextField(partTextField, placeholder: "파트를 입력해주세요")
        setupImageView()
        setupSelectImageButton()
        setupSubmitButton()
        partTextField.delegate = self
        setupUi()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }
    func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        view.addSubview(textField)
    }
    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    func setupSelectImageButton() {
        selectImageButton.setTitle("이미지 선택", for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectImageTapped), for: .touchUpInside)
        view.addSubview(selectImageButton)
    }
    func setupSubmitButton() {
        submitButton.setTitle("추가하기", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    func setupUi() {
        let sidePadding: CGFloat = 20
        let textFieldHeight: CGFloat = 40
        let imageSize: CGFloat = 200
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        partTextField.translatesAutoresizingMaskIntoConstraints = false
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            // Age TextField
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
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
    
    // MARK: - 이미지 관련 함수들 (selectImageTapped ~ uploadImage)
    // MARK: - 앨범에서 이미지 선택 후, 선택한 이미지를 서버에 보내 해당 이미지의 변환된 url을 받기 위함
    // '이미지 선택' 버튼 클릭 시 호출되는 함수
    @objc func selectImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary //앨범에서 사진 선택
        present(imagePickerController, animated: true, completion: nil)
    }
    // UIImagePickerControllerDelegate 설정하기
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let name = nameTextField.text
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            uploadImage(image: pickedImage, name: name!)
        }
        dismiss(animated: true, completion: nil)
    }
    // 내장되어 있는 함수. 좌측 상단에 cancel 버튼 생성 및 클릭 시 dismiss
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    // 선택한 이미지를 서버에 업로드 하는 함수
    func uploadImage(image: UIImage, name: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("🚨 Failed to convert image to data")
            return
        }
        // 우리가 연결해야 하는 서버 주소
        let url = URL(string: "http://3.35.236.83/image")!
        // request 생성하기
        var request = URLRequest(url: url)
        // 방법 설정 : POST (서버에 게시하겠다는 것)
        request.httpMethod = "POST"

        // 이 한 문단은 선택한 이미지를 서버에 올릴 수 있는 url 형태로 만들어주는 것 _ 외울필요전혀X
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(name).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        
        // UrlSession 객체 생성하기
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🚨 Error uploading image: \(error)")
                return
            }

            if let data = data {
                if let imageURLString = String(data: data, encoding: .utf8) {
                    // imageURLString을 사용하여 이미지 URL을 얻고 원하는 작업을 수행합니다.
                    print("✅ Image uploaded successfully. Image URL: \(imageURLString)")
                    self.convertedImgView = imageURLString
                } else {
                    print("🚨 Invalid response format. Expected a string.")
                }
            }
        }
        task.resume()
    }

    // 추가하기 버튼 클릭 시 실행되는 함수.
    @objc func submitButtonTapped() {
        guard imageView.image != nil else {
            print("No image selected")
            return
        }
        let name = nameTextField.text
        let age = Int(ageTextField.text!)
        let part = partTextField.text
        print("name = ", name!)
        print("age = ", age!)
        print("part = ", part!)
        // 입력한 내용들을 서버에 올리기 위해, 서버에 Add 해주는 함수 호출
        makePostRequest(with: convertedImgView, name: name!, age: age!, part: part!)
        dismiss(animated: true)
    }
}



