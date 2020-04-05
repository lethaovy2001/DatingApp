//
//  UserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
   private let userDetailsView: UserDetailsView = {
       let view = UserDetailsView(frame: .zero)
       view.backgroundColor = .white
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(userDetailsView)
        NSLayoutConstraint.activate([
            userDetailsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            userDetailsView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            userDetailsView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userDetailsView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = .white
    }

}
