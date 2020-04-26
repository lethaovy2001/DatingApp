//
//  ChatView.swift
//  DatingApp
//
//  Created by Vy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatView: UIView {
    private let inputContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.addShadow(withDirection: .top)
        return container
    }()
    private let inputTextView = InputTextView(placeholder: "Aa", cornerRadius: 20, isScrollable: true)
    private let sendButton = CustomButton(imageName: "paperplane.fill", size: 20, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private var inputContainerBottomAnchor = NSLayoutConstraint()
    private let titleButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        return button
    }()
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private let profileImageView = CircleImageView(imageName: "Vy")
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Vy"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    private var keyboardFrame = CGRect()
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.white
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true
        cv.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private let customNavigationView = CustomNavigationView(type: .chatMessage)
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        self.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(customNavigationView)
        
        addSubview(collectionView)
        addSubview(inputContainerView)
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(sendButton)
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
            inputContainerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            inputContainerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.PaddingValues.inputPadding))
        inputContainerBottomAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: Constants.PaddingValues.inputPadding),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            inputTextView.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.inputTextViewHeight),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.PaddingValues.inputPadding)
        ])
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            sendButton.topAnchor.constraint(equalTo: inputTextView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: customNavigationView.bottomAnchor)
        ])
    }
    
    func addDelegate(viewController: ChatViewController) {
        inputTextView.delegate = viewController
        viewController.textViewEditingDelegate = self
        viewController.keyboardDelegate = self
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: target,
            action: selector)
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }
    
    func getKeyboard(frame: CGRect) {
        self.keyboardFrame = frame
    }
    
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setleftButtonSelector(selector: selector, target: target)
    }
    
}

// MARK: TextViewEditingDelegate
extension ChatView: TextViewEditingDelegate {
    func didChange() {
        inputTextView.calculateBestHeight()
    }
    
    func beginEditing() {
        if (inputTextView.textColor == .lightGray) {
            inputTextView.text = ""
            inputTextView.textColor = .black
        }
    }
    
    func endEditing() {
        if (inputTextView.text == "") {
            inputTextView.text = "Aa"
            inputTextView.textColor = .lightGray
        }
    }
}

extension ChatView: KeyboardDelegate {
    func showKeyboard() {
        inputContainerBottomAnchor.constant = -self.keyboardFrame.height + Constants.PaddingValues.inputPadding*2
    }
    
    func hideKeyboard() {
        inputContainerBottomAnchor.constant = 0
    }
}




