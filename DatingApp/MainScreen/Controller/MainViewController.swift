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
        setupUI()
        setSelectors()
        mainView.setDataSource(uiViewController: self)
        locationService = LocationService(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
        let vc = ListMessagesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func profilePressed() {
        //TODO: remove mock data
        let model = UserModel(name: "Lan", age: 20, imageNames: modelController.getMockImageNames(), mainImageName: modelController.getMockImageNames()[0], work: "UW", bio: "I don’t want a partner in crime. I commit all my crimes on my own.\nI would never drag you into that \nI don’t want a partner in crime.")
        let viewModel = UserDetailsViewModel(model: model)
        let vc = UserDetailsViewController(viewModel: viewModel)
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
