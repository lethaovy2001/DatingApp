//
//  ListMessagesView.swift
//  DatingApp
//
//  Created by Vy Le on 4/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessagesView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let customNavigationView = CustomNavigationView(type: .listMessages)
    
    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(customNavigationView)
        self.addSubview(tableView)
        bringSubviewToFront(customNavigationView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavigationView.topAnchor.constraint(equalTo: self.topAnchor),
            customNavigationView.leftAnchor.constraint(equalTo: self.leftAnchor),
            customNavigationView.rightAnchor.constraint(equalTo: self.rightAnchor),
            customNavigationView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customNavigationView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addDelegate(viewController: ListMessagesViewController) {
        customNavigationView.tapDelegate = viewController
    }
    
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setleftButtonSelector(selector: selector, target: target)
    }
}

