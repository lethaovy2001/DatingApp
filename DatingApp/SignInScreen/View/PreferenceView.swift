//
//  PreferenceView.swift
//  DatingApp
//
//  Created by Vy Le on 5/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class PreferenceView: UIView {
    // MARK: - Properties
    private let genderLabel = SectionTitleLabel(title: "Gender")
    private let interestLabel = SectionTitleLabel(title: "Interested in")
    private var genderSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Female"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.amour
        sc.selectedSegmentIndex = 1
        return sc
    }()
    private var interestedSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Female"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.amour
        sc.selectedSegmentIndex = 1
        return sc
    }()
    private let saveButton = RoundedButton(title: "Save", color: UIColor.amour)
    private let birthdayLabel = SectionTitleLabel(title: "Birthday")
    private let birthdayTextField = CustomTextField(placeholder: "mm-dd-yyyy")
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        addSubview(genderLabel)
        addSubview(interestLabel)
        addSubview(genderSegmentedControl)
        addSubview(interestedSegmentedControl)
        addSubview(saveButton)
        addSubview(birthdayLabel)
        addSubview(birthdayTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            genderLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            genderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
        ])
        NSLayoutConstraint.activate([
            genderSegmentedControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderSegmentedControl.widthAnchor.constraint(equalToConstant: 160),
            genderSegmentedControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
            genderSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            interestLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 36),
            interestLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
        ])
        NSLayoutConstraint.activate([
            interestedSegmentedControl.topAnchor.constraint(equalTo: interestLabel.bottomAnchor, constant: 8),
            interestedSegmentedControl.widthAnchor.constraint(equalToConstant: 160),
            interestedSegmentedControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
            interestedSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            birthdayLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: interestedSegmentedControl.bottomAnchor, constant: 36),
            birthdayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
        ])
        NSLayoutConstraint.activate([
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
            birthdayTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -36),
        ])
        NSLayoutConstraint.activate([
            saveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            saveButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 36),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setGenderSegmentControlSelector(selector: Selector) {
        genderSegmentedControl.addTarget(self, action: selector, for: .valueChanged)
    }
    
    func setInterestSegmentControlSelector(selector: Selector) {
        interestedSegmentedControl.addTarget(self, action: selector, for: .valueChanged)
    }
    
    func setSaveButton(selector: Selector, target: UIViewController) {
        saveButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func getGenderSelection() -> String {
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            return "male"
        } else {
            return "female"
        }
    }
    
    func getInterestedSelection() -> String {
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            return "male"
        } else {
            return "female"
        }
    }
    
    func getBirthdayText() -> String? {
        if birthdayTextField.text != "" {
            return birthdayTextField.text
        }
        return nil
    }
}
