//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let mainView: MainView = {
        let view = MainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let modelController = MainModelController()
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    private func setSelectors() {
        mainView.setLikeSelector(selector: #selector(likePressed), target: self)
        mainView.setDislikeSelector(selector: #selector(dislikePressed), target: self)
        mainView.setProfileSelector(selector: #selector(profilePressed), target: self)
        mainView.setMessageSelector(selector: #selector(messagePressed), target: self)
    }
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setSelectors()
        mainView.setDataSource(uiViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!UserDefaults.standard.isLoggedIn()) {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    // MARK: Actions
    @objc func likePressed() {
       
    }
    
    @objc func dislikePressed() {
        
    }
    
    @objc func messagePressed() {
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func profilePressed() {
        let vc = UserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: SwipeableCardDataSource
extension MainViewController: SwipeableCardDataSource {
    func card(forItemAt index: Int) -> SwipeCardView {
            let card = SwipeCardView()
            card.dataSource = modelController.getMockUsers()[index]
            return card
    }
    
    func numberOfCards() -> Int {
        return modelController.getMockUsers().count
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
}
