//
//  ListMessageViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessagesViewController: UIViewController {
    
    private let listMessagesView: ListMessagesView = {
        let view = ListMessagesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(listMessagesView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            listMessagesView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listMessagesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listMessagesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listMessagesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: Actions
    @objc func newMessagePressed() {
        
    }
    
}
