//// AddMovieViewController
//
//import UIKit
//import RealmSwift
//
//class AddMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    let titleTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Movie Title"
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    let summaryTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Movie Summary"
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    let saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Save", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        view.addSubview(titleTextField)
//        view.addSubview(summaryTextField)
//        view.addSubview(saveButton)
//
//        // Add constraints here
//        addConstraints()
//
//        // Add a target to the saveButton to call the save function
//        saveButton.addTarget(self, action: #selector(saveMovie), for: .touchUpInside)
//    }
//
//    func addConstraints() {
//        NSLayoutConstraint.activate([
//            // titleTextField constraints
//            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            // summaryTextField constraints
//            summaryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            summaryTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
//            summaryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            summaryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            // saveButton constraints
//            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            saveButton.topAnchor.constraint(equalTo: summaryTextField.bottomAnchor, constant: 30),
//        ])
//    }
//
//    @objc func saveMovie() {
//        guard let title = titleTextField.text, let summary = summaryTextField.text else {
//            // Handle invalid input
//            return
//        }
//
//        // Create a Movie object with the entered data
//        let movie = Movie()
//        movie.title = title
//        movie.summary = summary
//
//        // Save the movie object to Realm
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(movie)
//            }
//            print("Movie saved to Realm")
//        } catch {
//            print("Error saving movie: \(error.localizedDescription)")
//        }
//
//        // Close the AddMovieViewController
//        dismiss(animated: true, completion: nil)
//    }
//}
