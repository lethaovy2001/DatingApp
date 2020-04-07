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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userDetailsView.setEditSelector(selector: #selector(editButtonPressed), target: self)
    }
    
    private func setupUI() {
        view.addSubview(userDetailsView)
        NSLayoutConstraint.activate([
            userDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            userDetailsView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            userDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            userDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    //TODO: editButtonPressed
    @objc func editButtonPressed() {
        
    }
}
