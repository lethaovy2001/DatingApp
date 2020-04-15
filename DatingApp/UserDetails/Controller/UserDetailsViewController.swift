//
//  UserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

class UserDetailsViewController: UIViewController {
    private let userDetailsView = UserDetailsView()
    private var viewModel: UserDetailsViewModel!
    private var database: Firestore!
    private let modelController = MainModelController()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        addNavigationBar()
        setupUI()
        userDetailsView.setEditSelector(selector: #selector(editButtonPressed), target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        fetchUserInfo()
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(userDetailsView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            userDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            userDetailsView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            userDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            userDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addNavigationBar() {
        let navBar = self.navigationController?.navigationBar
        let navItem = self.navigationItem
        navBar?.tintColor = UIColor.orange
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
    
    // MARK: Actions
    @objc func editButtonPressed() {
        let vc = EditUserDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: Firebase
    private func fetchUserInfo() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID is nil")
            return
        }
        database.collection("users").document(userID).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            print("Current data: \(data)")
            let model = UserModel(name: data["first_name"] as! String,
                                  age: data["age"] as! Int,
                                  imageNames: self.modelController.getMockImageNames(),
                                  mainImageName: self.modelController.getMockImageNames()[0],
                                  work: data["work"] as! String,
                                  bio: data["bio"] as! String)
            self.viewModel = UserDetailsViewModel(model: model)
            self.userDetailsView.viewModel = self.viewModel
        }
    }
}
