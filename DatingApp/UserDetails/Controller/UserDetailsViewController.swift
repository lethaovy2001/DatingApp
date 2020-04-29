//
//  UserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    private let userDetailsView = UserDetailsView()
    private var viewModel: UserDetailsViewModel!
    private let modelController = MainModelController()
    private let firebaseService = FirebaseService()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        reloadUserInfo()
    }
    
    // MARK: Setup
    private func setup() {
        addNavigationBar()
        setupUI()
        setSelectors()
    }
    
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
    
    private func setSelectors() {
        userDetailsView.setEditSelector(selector: #selector(editButtonPressed), target: self)
        userDetailsView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
    }
    
    func addNavigationBar() {
        let navBar = self.navigationController?.navigationBar
        let navItem = self.navigationItem
        navBar?.tintColor = UIColor.amour
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
    
    // MARK: Actions
    @objc func editButtonPressed() {
        let vc = EditUserDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Firebase
    func reloadUserInfo() {
        self.modelController.getData {
            self.viewModel = UserDetailsViewModel(model: self.modelController.getUserInfo())
            self.userDetailsView.viewModel = self.viewModel
        }
    }
}
