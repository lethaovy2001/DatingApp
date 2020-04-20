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
    private var viewModel: UserDetailsViewModel
    
    // MARK: Initializer
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        userDetailsView.viewModel = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        setupUI()
        userDetailsView.setEditSelector(selector: #selector(editButtonPressed), target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        navBar?.tintColor = UIColor.amour
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
    
    // MARK: Actions
    @objc func editButtonPressed() {
        let vc = EditUserDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
