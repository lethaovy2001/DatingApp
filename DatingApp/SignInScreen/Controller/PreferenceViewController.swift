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
    private var database: Database
    private var auth: Authentication
    var user: UserModel!
    private let converter = DateConverter()
    
    // MARK: - Initializer
    init(authentication: Authentication, database: Database) {
        self.database = database
        self.auth = authentication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mainView.setSaveButton(selector: #selector(saveButtonPressed), target: self)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    // MARK: Actions
    @objc private func saveButtonPressed() {
        let gender = mainView.getGenderSelection()
        let interestedGender = mainView.getInterestedSelection()
        if let birthday = mainView.getBirthdayText() {
            let date = converter.convertToDate(dateString: birthday)
            user.gender = gender
            user.interestedIn = interestedGender
            user.birthday = date
            self.database.saveProfile(ofUser: user)
            self.database.updateListOfUsers()
            let viewModel = UserDetailsViewModel(model: user)
            let vc = EditUserDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
