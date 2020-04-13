//
//  EditUserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

class EditUserDetailsViewController: UIViewController {
    private let editUserDetailsView = EditUserDetailsView()
    private var viewModel: UserDetailsViewModel
    var textViewEditingDelegate: TextViewEditingDelegate?
    private var database: Firestore!
    private let modelController = MainModelController()
    
    // MARK: Init
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        editUserDetailsView.viewModel = self.viewModel
        super.init(nibName: nil, bundle: nil)
        database = Firestore.firestore()
        
        editUserDetailsView.databaseDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        editUserDetailsView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        editUserDetailsView.addDelegate(viewController: self)
        editUserDetailsView.setLogoutSelector(selector: #selector(logoutPressed), target: self)
        editUserDetailsView.setSaveSelector(selector: #selector(saveButtonPressed), target: self)
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(editUserDetailsView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            editUserDetailsView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editUserDetailsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            editUserDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            editUserDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Actions
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    @objc func logoutPressed() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.synchronize()
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func saveButtonPressed() {
        editUserDetailsView.savePressed()
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    // MARK: Firebase
    private func fetchUserInfo() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User Id is nil")
            return
        }
        database.collection("users").document(userID)
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
          guard let data = document.data() else {
            print("Document data was empty.")
            return
          }
            print("Current data: \(data)")
            let model = UserModel(name: data["first_name"] as! String, age: data["age"] as! Int, imageNames: self.modelController.getMockImageNames(), mainImageName: self.modelController.getMockImageNames()[0], work: "", bio: "")
            self.viewModel = UserDetailsViewModel(model: model)
            self.editUserDetailsView.viewModel = self.viewModel
        }
    }
    
    private func updateDatabaseWithUID(values: [String: AnyObject]) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        database.collection("users").document(userID).setData(values) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

// MARK: UITextViewDelegate
extension EditUserDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewEditingDelegate?.didChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewEditingDelegate?.beginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
         textViewEditingDelegate?.endEditing()
    }
}

extension EditUserDetailsViewController: DatabaseDelegate {
    func didTapSaveButton(viewModel: UserDetailsViewModel) {
        let changes = (viewModel.name, viewModel.age, viewModel.images, viewModel.mainImageName, viewModel.work, viewModel.bio)
        viewModel.update(with: changes)
        let dictionary: [String: AnyObject] = [
            "first_name": viewModel.name as AnyObject,
            "age": viewModel.age as AnyObject,
            "bio": viewModel.bio as AnyObject,
            "work": viewModel.work as AnyObject,
        ]
        updateDatabaseWithUID(values: dictionary)
    }
}

protocol DatabaseDelegate {
    func didTapSaveButton(viewModel: UserDetailsViewModel)
}
