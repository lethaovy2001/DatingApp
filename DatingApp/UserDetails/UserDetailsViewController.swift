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
        addNavigationBar()
        setupUI()
        userDetailsView.setEditSelector(selector: #selector(editButtonPressed), target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    func addNavigationBar() {
        let navBar = self.navigationController?.navigationBar
        let navItem = self.navigationItem
        navBar?.tintColor = UIColor.orange
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
    
    //TODO: editButtonPressed
    @objc func editButtonPressed() {
        let vc = EditUserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}
