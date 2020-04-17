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
    private var locationManager: CLLocationManager?
    
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.requestWhenInUseAuthorization()
    }
    
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
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        getUserLocation()
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
        if let location = locations.last {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            default:
                break
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            presentAlert()
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
            presentAlert()
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        default:
            break
        }
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
}
