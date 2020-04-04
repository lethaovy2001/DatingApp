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
    
    private let userImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]
    private lazy var users = [
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]])]
    
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
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setSelectors()
        mainView.setDataSource(uiViewController: self)
    }
    
    private func setSelectors() {
        mainView.setLikeSelector(selector: #selector(likePressed), target: self)
        mainView.setDislikeSelector(selector: #selector(dislikePressed), target: self)
        mainView.setProfileSelector(selector: #selector(profilePressed), target: self)
        mainView.setMessageSelector(selector: #selector(messagePressed), target: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!UserDefaults.standard.isLoggedIn()) {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func likePressed() {
       
    }
    
    @objc func dislikePressed() {
        
    }
    
    @objc func messagePressed() {
        let vc = ChatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func profilePressed() {
        
    }
}

extension MainViewController: SwipeableCardDataSource {
    
    func card(forItemAt index: Int) -> SwipeCardView {
            let card = SwipeCardView()
            card.dataSource = users[index]
            return card
    }
    
    func numberOfCards() -> Int {
        return users.count
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

