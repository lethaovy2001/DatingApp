//
//  EditUserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsViewController: UIViewController {
    private let editUserDetails = EditUserDetailsView()
    private var viewModel: UserDetailsViewModel
    
    //MARK: Init
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        editUserDetails.viewModel = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        editUserDetails.addTapGesture(target: self, selector: #selector(dismissKeyboard))
    }
    
    //MARK: Setup
    private func setupUI() {
        view.addSubview(editUserDetails)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            editUserDetails.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editUserDetails.leftAnchor.constraint(equalTo: view.leftAnchor),
            editUserDetails.rightAnchor.constraint(equalTo: view.rightAnchor),
            editUserDetails.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: Actions
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
}
