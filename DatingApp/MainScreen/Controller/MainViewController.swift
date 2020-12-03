//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController : UIViewController {
    // MARK: - Properties
    private let mainView = MainView()
    private var locationService: LocationService!
    private let database: Database
    private let auth: Authentication
    private var modelController: MainModelController
    private var userModelController = UserModelController()
    var autoSwipeDelegate: AutoSwipeDelegate?
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared,
         database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        self.modelController = MainModelController(database: database)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "mainView"
        setup()
        loadUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setSelectors()
        mainView.setDataSource(uiViewController: self)
        mainView.addDelegate(viewController: self)
        locationService = LocationService(viewController: self)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setSelectors() {
        mainView.setLikeSelector(selector: #selector(likePressed), target: self)
        mainView.setDislikeSelector(selector: #selector(dislikePressed), target: self)
        mainView.setProfileSelector(selector: #selector(profilePressed), target: self)
        mainView.setMessageSelector(selector: #selector(messagePressed), target: self)
        mainView.setDoneSelector(selector: #selector(doneAlertPressed), target: self)
    }
    
    private func loadUserProfile() {
        guard let id = auth.getCurrentUserId() else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: false)
            return
        }
        userModelController.loadCurrentUserProfile(id: id) {
            self.fetchAllUsers()
        }
    }
    
    private func fetchAllUsers() {
        guard let gender = self.userModelController.interestedInGender else { return }
        self.modelController.getAllUsers(filterBy: gender) {
            self.mainView.reloadSwipeViews()
        }
    }
    
    // MARK: Actions
    @objc private func likePressed() {
        autoSwipeDelegate?.swipe(direction: .right)
    }
    
    @objc private func dislikePressed() {
        autoSwipeDelegate?.swipe(direction: .left)
    }
    
    @objc private func messagePressed() {
        let vc = ListMessagesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func profilePressed() {
        let vc = UserDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func doneAlertPressed() {
        mainView.hideAlert()
    }
    
    @objc private func reloadUsers() {
        if modelController.getUsers().count == 0 {
            fetchAllUsers()
        }
    }
    
    func showAlert() {
        mainView.showAlert()
    }
}

// MARK: - SwipeableCardDataSource
extension MainViewController: SwipeableCardDataSource {
    func reloadData() {
        fetchAllUsers()
    }
    
    func card(forItemAt index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = modelController.getUsers()[index]
        return card
    }
    
    func numberOfCards() -> Int {
        return modelController.getUsers().count
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationService.didUpdateLocations(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationService.didChangeAuthorization(status: status)
    }
}

// MARK: - UserChoiceDelegate
extension MainViewController: UserChoiceDelegate {
    func like(_ user: UserModel) {
        if let id = user.id {
            database.saveLikeUser(withId: id)
        }
    }
    
    func dislike(_ user: UserModel) {
        if let id = user.id {
            database.saveDislikeUser(withId: id)
        }
    }
}
