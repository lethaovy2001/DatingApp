//
//  UserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    // MARK: Properties
    private let userDetailsView = UserDetailsView()
    private let modelController = UserDetailsModelController()
    var viewModel: UserDetailsViewModel?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let viewModel = viewModel {
            let vc = EditUserDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Firebase
    func reloadUserInfo() {
        if let id = viewModel?.id, id != modelController.getCurrentUserId() {
            self.modelController.getData(id: viewModel?.id) {
                self.viewModel = UserDetailsViewModel(model: self.modelController.getUserInfo(), type: .otherUser)
                self.userDetailsView.viewModel = self.viewModel
                self.userDetailsView.doneLoading()
            }
        } else {
            self.modelController.getData(id: modelController.getCurrentUserId()) {
                self.viewModel = UserDetailsViewModel(model: self.modelController.getUserInfo(), type: .currentUser)
                self.userDetailsView.viewModel = self.viewModel
                self.userDetailsView.doneLoading()
            }
        }
    }
}
