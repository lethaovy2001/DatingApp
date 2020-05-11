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
        registerCellId()
        listMessagesView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
        listMessagesView.addDelegate(viewController: self)
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
    
    private func registerCellId() {
        listMessagesView.tableView.register(ListMessageCell.self, forCellReuseIdentifier: Constants.messageCellId)
        listMessagesView.tableView.delegate = self
        listMessagesView.tableView.dataSource = self
    }
    
    // MARK: Actions
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: UITableViewDataSource
extension ListMessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.messageCellId, for: indexPath) as! ListMessageCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.nameLabel.text = "Alex"
        cell.chatLabel.text = "Sure!"
        return cell
    }
}

// MARK: UITableViewDelegate
extension ListMessagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListMessagesViewController: ImageTapGestureDelegate {
    func didTap() {
        let vc = UserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
