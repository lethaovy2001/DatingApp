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
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
}
