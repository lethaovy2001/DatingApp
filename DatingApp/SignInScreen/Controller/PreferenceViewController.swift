//
//  PreferenceViewController.swift
//  DatingApp
//
//  Created by Vy Le on 5/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {
    private let mainView: PreferenceView = {
        let view = PreferenceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var firebaseService = FirebaseService()
    var user: UserModel!
    private let converter = Converter()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mainView.setSaveButton(selector: #selector(saveButtonPressed), target: self)
    }
    
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
    
    // MARK: Actions
    @objc func saveButtonPressed() {
        let gender = mainView.getGenderSelection()
        let interestedGender = mainView.getInterestedSelection()
        if let birthday = mainView.getBirthdayText(),
            let id = firebaseService.getUserID() {
            let date = converter.convertToDate(dateString: birthday)
            let dictionary: [String: Any] = [
                "gender": gender,
                "interestedIn": interestedGender,
                "birthday": date,
                "id": id
            ]
            self.firebaseService.updateDatabase(with: dictionary)
            let viewModel = UserDetailsViewModel(model: user)
            let vc = EditUserDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
