//
//  EditUserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsView: UIView {
    private let verticalStackView = CustomStackView(axis: .vertical)
    private let horizontalStackView1 = CustomStackView(axis: .horizontal)
    private let horizontalStackView2 = CustomStackView(axis: .horizontal)
    private let addImageButton1 = AddImageButton()
    private let addImageButton2 = AddImageButton()
    private let addImageButton3 = AddImageButton()
    private let addImageButton4 = AddImageButton()
    private let addImageButton5 = AddImageButton()
    private let addImageButton6 = AddImageButton()
    private var imageButtons: [AddImageButton] = []
    private var featureLabel = SectionTitleLabel(title: "Featured")
    private let bioLabel = SectionTitleLabel(title: "Bio")
    private let detailsLabel = SectionTitleLabel(title: "Details")
    private let bioTextView = InputTextView(placeholder: "Describe Yourself...", cornerRadius: 10, isScrollable: false)
    private let workTextField = CustomTextField()
    private let saveButton = RoundedButton(title: "Save", color: .orange)
    private let logoutButton = RoundedButton(title: "Logout", color: Constants.Colors.orangeRed)
    private let mainProfileImage = CustomImageView(imageName: "Vy.jpg", cornerRadius: 50)
    private let nameLabel = CustomLabel(text: "Unknown", textColor: .darkGray, textSize: 28, textWeight: .heavy)
    private let scrollView = CustomScrollView()
    
    private var cardImages: [String]?
    var viewModel: UserDetailsViewModel! {
        didSet {
            nameLabel.setText(text: viewModel.name)
            workTextField.setText(text: viewModel.work)
            bioTextView.setText(text: viewModel.bio)
            mainProfileImage.setName(name: viewModel.mainImageName)
            cardImages = viewModel.images
            if let cardImages = cardImages {
                var index = 0
                for image in cardImages {
                    imageButtons[index].setImage(name: image)
                    index = index + 1
                }
            }
        }
    }
      var databaseDelegate: DatabaseDelegate?
    
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
        appendImageButtons()
    }
    
    private func setUpSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
    
    private func appendImageButtons() {
        imageButtons = [addImageButton1, addImageButton2, addImageButton3, addImageButton4, addImageButton5, addImageButton6]
    }
    
    private func addSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        scrollView.addSubview(bioLabel)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(workTextField)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(logoutButton)
        scrollView.addSubview(mainProfileImage)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(featureLabel)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        horizontalStackView1.addArrangedSubview(addImageButton1)
        horizontalStackView1.addArrangedSubview(addImageButton2)
        horizontalStackView1.addArrangedSubview(addImageButton3)
        horizontalStackView2.addArrangedSubview(addImageButton4)
        horizontalStackView2.addArrangedSubview(addImageButton5)
        horizontalStackView2.addArrangedSubview(addImageButton6)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            mainProfileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
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
            verticalStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: featureLabel.bottomAnchor, constant: 12),
            verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            verticalStackView.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 2/3)
        ])
        NSLayoutConstraint.activate([
            saveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            saveButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 36),
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
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
            let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
                target: target,
                action: selector)
            self.addGestureRecognizer(tapRecognizer)
            self.isUserInteractionEnabled = true
    }
    
    func setLogoutSelector(selector: Selector, target: UIViewController) {
        logoutButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSaveSelector(selector: Selector, target: UIViewController) {
        saveButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}

// MARK: TextViewEditingDelegate
extension EditUserDetailsView: TextViewEditingDelegate {
    func didChange() {
         bioTextView.calculateBestHeight()
    }
    
    func beginEditing() {
        if (bioTextView.textColor == .lightGray) {
            bioTextView.text = ""
            bioTextView.textColor = .black
        }
    }
    
    func endEditing() {
        if (bioTextView.text == "") {
            bioTextView.text = "Describe Yourself..."
            bioTextView.textColor = .lightGray
        }
    }
}

extension EditUserDetailsView {
    func savePressed() {
        print("LALA")
        
        let newModel = UserModel(name: viewModel.name, age: viewModel.age, imageNames: viewModel.images, mainImageName: viewModel.images[0], work: workTextField.text!, bio: bioTextView.text)
        self.viewModel = UserDetailsViewModel(model: newModel)
        databaseDelegate?.didTapSaveButton(viewModel: viewModel)
    }
}
