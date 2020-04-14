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
    
    // MARK: Init
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        editUserDetailsView.viewModel = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        setupUI()
        editUserDetailsView.databaseDelegate = self
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
        let vc =  UserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: false)
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
    func shouldUpdateDatabase(viewModel: UserDetailsViewModel) {
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
