//
//  PreferenceViewController.swift
//  DatingApp
//
//  Created by Vy Le on 5/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class PreferenceViewController : UIViewController {
    // MARK: - Properties
    private let mainView = PreferenceView()
    var user: UserModel!
    private let converter = DateConverter()
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.view.accessibilityIdentifier = "preferenceView"
        mainView.setSaveButton(selector: #selector(saveButtonPressed), target: self)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(mainView)
        view.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func saveButtonPressed() {
        if let birthday = mainView.getBirthdayText() {
            let date = converter.convertToDate(dateString: birthday)
            user.gender = mainView.getGenderSelection()
            user.interestedIn = mainView.getInterestedSelection()
            user.birthday = date
            let vc = EditUserDetailsViewController()
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
