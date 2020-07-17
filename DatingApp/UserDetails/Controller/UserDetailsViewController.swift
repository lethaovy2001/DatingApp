//
//  UserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewController : UIViewController {
    // MARK: - Properties
    private let userDetailsView = UserDetailsView()
    private let modelController: UserDetailsModelController
    private let database: Database
    private let auth: Authentication
    var viewModel: UserDetailsViewModel? {
        didSet {
            reloadUserInfo()
        }
    }
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared, database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        self.modelController = UserDetailsModelController(database: database)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "userDetailsView"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        reloadUserInfo()
    }
    
    // MARK: - Setup
    private func setup() {
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
    
    // MARK: Actions
    @objc private func editButtonPressed() {
        let vc = EditUserDetailsViewController()
        vc.user = modelController.getUserInfo()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Firebase
    func reloadUserInfo() {
        if let id = viewModel?.id, id != auth.getCurrentUserId() {
            self.modelController.getData(id: id) {
                self.viewModel = UserDetailsViewModel(model: self.modelController.getUserInfo(), type: .otherUser)
                self.viewModel?.configure(self.userDetailsView)
                self.userDetailsView.doneLoading()
            }
        } else {
            self.modelController.getData(id: auth.getCurrentUserId()) {
                self.viewModel = UserDetailsViewModel(model: self.modelController.getUserInfo(), type: .currentUser)
                self.viewModel?.configure(self.userDetailsView)
                self.userDetailsView.doneLoading()
            }
        }
    }
}
