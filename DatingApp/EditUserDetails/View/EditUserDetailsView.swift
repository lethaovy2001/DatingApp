//
//  EditUserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsView: UIView {
    private let imageButtonsContainerView = ImageButtonsContainerView()
    private var featureLabel = SectionTitleLabel(title: "Featured")
    private let bioLabel = SectionTitleLabel(title: "Bio")
    private let detailsLabel = SectionTitleLabel(title: "Details")
    private let bioTextView = InputTextView(placeholder: "Describe Yourself...", cornerRadius: 10, isScrollable: false)
    private let workTextField = CustomTextField()
    private let saveButton = RoundedButton(title: "Save", color: UIColor.amour)
    private let logoutButton = RoundedButton(title: "Logout", color: UIColor.orangeRed)
    private let mainProfileImage = CustomImageView(imageName: "user", cornerRadius: 50)
    private let nameLabel = CustomLabel(text: "Unknown", textColor: .darkGray, textSize: 28, textWeight: .heavy)
    private let scrollView = CustomScrollView()
    private let customNavigationView = CustomNavigationView(type: .editUserDetails)
    private let errorLabel = CustomLabel(text: "Error", textColor: UIColor.red, textSize: 14, textWeight: .regular)
    private var cardImages: [UIImage]?
    var viewModel: UserDetailsViewModel! {
        didSet {
            nameLabel.setText(text: viewModel.name)
            workTextField.setText(text: viewModel.work)
            bioTextView.setText(text: viewModel.bio)
            cardImages = viewModel.images
            if !viewModel.images.isEmpty {
                mainProfileImage.setImage(image: viewModel.images[0])
                if let cardImages = cardImages {
                    var index = 0
                    for image in cardImages.reversed() {
                        imageButtonsContainerView.setImage(image: image, index: index)
                        index = index + 1
                    }
                }
            }
        }
    }
    private var modelController = MainModelController()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setUp() {
        setUpSelf()
        addSubviews()
        setUpConstraints()
        setUpErrorLabel()
    }
    
    private func setUpSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
    
    private func setUpErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 2
    }
    
    private func addSubviews() {
        addSubview(customNavigationView)
        addSubview(scrollView)
        scrollView.addSubview(bioLabel)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(workTextField)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(logoutButton)
        scrollView.addSubview(mainProfileImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(featureLabel)
        scrollView.addSubview(imageButtonsContainerView)
        scrollView.addSubview(errorLabel)
        bringSubviewToFront(customNavigationView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            customNavigationView.topAnchor.constraint(equalTo: self.topAnchor),
            customNavigationView.leftAnchor.constraint(equalTo: self.leftAnchor),
            customNavigationView.rightAnchor.constraint(equalTo: self.rightAnchor),
            customNavigationView.heightAnchor.constraint(equalToConstant: 100),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            mainProfileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainProfileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainProfileImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            mainProfileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainProfileImage.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: mainProfileImage.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            bioLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            bioLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
            bioTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            bioTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
        ])
        NSLayoutConstraint.activate([
            detailsLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 16),
            detailsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            workTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor),
            workTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            workTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
        ])
        NSLayoutConstraint.activate([
            featureLabel.topAnchor.constraint(equalTo: workTextField.bottomAnchor, constant: 16),
            featureLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            imageButtonsContainerView.topAnchor.constraint(equalTo: featureLabel.bottomAnchor, constant: 12),
            imageButtonsContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            imageButtonsContainerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            imageButtonsContainerView.heightAnchor.constraint(equalTo: imageButtonsContainerView.widthAnchor, multiplier: 2/3)
        ])
        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36),
            errorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -36),
            errorLabel.topAnchor.constraint(equalTo: imageButtonsContainerView.bottomAnchor, constant: 12),
            errorLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        NSLayoutConstraint.activate([
            saveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            saveButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 36),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            logoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            logoutButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 12),
            logoutButton.heightAnchor.constraint(equalToConstant: 60),
            logoutButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12),
        ])
    }
    
    func addDelegate(viewController: EditUserDetailsViewController) {
        bioTextView.delegate = viewController
        viewController.textViewEditingDelegate = self
        imageButtonsContainerView.addDelegate(viewController: viewController)
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }
    
    func setLogoutSelector(selector: Selector, target: UIViewController) {
        logoutButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSaveSelector(selector: Selector, target: UIViewController) {
        saveButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setBackSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setleftButtonSelector(selector: selector, target: target)
    }
    
    func setAddImageSelector(selector: Selector, target: UIViewController) {
        imageButtonsContainerView.setAddImageSelector(selector: selector, target: target)
    }
    
    func setSelectedButton(sender: UIButton) {
        imageButtonsContainerView.setSelectedButton(sender: sender)
    }
    
    func getBioText() -> String? {
        if bioTextView.text != "" {
            return bioTextView.text
        }
        return nil
    }
    
    func getWorkText() -> String? {
        if workTextField.text != "" {
            return workTextField.text
        }
        return nil
    }
    
    func getImages() -> [UIImage]? {
        if imageButtonsContainerView.getImages().count == 0 {
            return nil
        }
        return imageButtonsContainerView.getImages()
    }
    
    func showError(message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}

// MARK: TextViewEditingDelegate
extension EditUserDetailsView: TextViewEditingDelegate {
    func didChange() {
        bioTextView.calculateBestHeight()
    }
    
    func beginEditing() {
        if (bioTextView.textColor == .customLightGray) {
            bioTextView.text = ""
            bioTextView.textColor = .black
        }
    }
    
    func endEditing() {
        if (bioTextView.text == "") {
            bioTextView.text = "Describe Yourself..."
            bioTextView.textColor = .customLightGray
        }
    }
}
