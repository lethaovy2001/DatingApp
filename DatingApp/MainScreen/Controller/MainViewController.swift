//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    private var locationService: LocationService!
    
    private let mainView: MainView = {
        let view = MainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let modelController = MainModelController()
    private var firebaseService: FirebaseService!
    var autoSwipeDelegate: AutoSwipeDelegate?
    
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
        mainView.setDoneSelector(selector: #selector(doneAlertPressed), target: self)
    }
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseService = FirebaseService()
        setupUI()
        setSelectors()
        mainView.setDataSource(uiViewController: self)
        mainView.addDelegate(viewController: self)
        locationService = LocationService(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (!UserDefaults.standard.isLoggedIn() || firebaseService.getUserID() == nil) {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    // MARK: Actions
    @objc func likePressed() {
        autoSwipeDelegate?.swipe(direction: .right)
    }
    
    @objc func dislikePressed() {
        autoSwipeDelegate?.swipe(direction: .left)
    }
    
    @objc func messagePressed() {
        let vc = ListMessagesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func profilePressed() {
        let vc = UserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doneAlertPressed() {
        mainView.hideAlert()
    }
    
    func showAlert() {
        mainView.showAlert()
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

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationService.didUpdateLocations(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationService.didChangeAuthorization(status: status)
    }
}
