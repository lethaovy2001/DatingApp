//
//  ChatView.swift
//  DatingApp
//
//  Created by Vy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatView : UIView {
    // MARK: - Properties
    private let inputContainerView = InputContainerView()
    private let inputTextView = InputTextView(placeholder: "Aa", cornerRadius: 20, isScrollable: true)
    private let addImageButton = CustomButton(imageName: "photo", size: 20, color: .amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let sendButton = CustomButton(imageName: "paperplane.fill", size: 20, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let customNavigationView = CustomNavigationView(type: .chatMessage)
    private let loadingView = LoadingAnimationView()
    private let newChatAlertView = CustomAlertView(type: .newMessage)
    private var inputContainerBottomAnchor = NSLayoutConstraint()
    private var keyboardFrame = CGRect()
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true
        cv.allowsSelection = true
        cv.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.keyboardDismissMode = .interactive
        cv.backgroundColor = .white
        return cv
    }()
    var viewModel: UserDetailsViewModel? {
        didSet {
            customNavigationView.setTitle(title: viewModel?.name ?? "Unknown")
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = .white
        addSubviews()
        setUpConstraints()
        setAccessibilityIdentifier()
    }
    
    private func setAccessibilityIdentifier() {
        inputTextView.accessibilityIdentifier = "inputTextView"
        sendButton.accessibilityIdentifier = "sendButton"
        addImageButton.accessibilityIdentifier = "addImageButton"
    }
    
    private func addSubviews() {
        addSubview(customNavigationView)
        addSubview(collectionView)
        addSubview(inputContainerView)
        addSubview(loadingView)
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(sendButton)
        inputContainerView.addSubview(addImageButton)
        bringSubviewToFront(customNavigationView)
        bringSubviewToFront(inputContainerView)
    }
    
    private func setUpConstraints() {
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.PaddingValues.inputPadding))
        inputContainerBottomAnchor.isActive = true
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: self.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
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
        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: addImageButton.rightAnchor),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            inputTextView.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.inputTextViewHeight),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.PaddingValues.inputPadding)
        ])
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 54),
            sendButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            sendButton.topAnchor.constraint(equalTo: inputTextView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            addImageButton.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor),
            addImageButton.widthAnchor.constraint(equalToConstant: 54),
            addImageButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            addImageButton.topAnchor.constraint(equalTo: inputTextView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            collectionView.topAnchor.constraint(equalTo: customNavigationView.bottomAnchor)
        ])
    }
    
    func addDelegate(viewController: ChatViewController) {
        inputTextView.delegate = viewController
        customNavigationView.tapDelegate = viewController
        viewController.textViewEditingDelegate = self
        viewController.keyboardDelegate = self
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: target,
            action: selector)
        tapRecognizer.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: Selectors
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setleftButtonSelector(selector: selector, target: target)
    }
    
    func setAddImageButtonSelector(selector: Selector, target: UIViewController) {
        addImageButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSendButtonSelector(selector: Selector, target: UIViewController) {
        sendButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setDoneSelector(selector: Selector, target: UIViewController) {
        newChatAlertView.setDoneSelector(selector: selector, target: target)
    }
    
    // MARK: Actions
    func getKeyboard(frame: CGRect) {
        self.keyboardFrame = frame
    }
    
    func getInputText() -> String? {
        if (inputTextView.hasText()) {
            return inputTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }
    
    func setEmptyInputText() {
        inputTextView.text = nil
    }
    
    func doneLoading() {
        self.loadingView.removeFromSuperview()
    }
    
    // MARK: Alert View
    func showNewConversationAlert() {
        newChatAlertView.isHidden = false
        newChatAlertView.accessibilityIdentifier = "alertView"
        self.addSubview(newChatAlertView)
        bringSubviewToFront(newChatAlertView)
        NSLayoutConstraint.activate([
            newChatAlertView.topAnchor.constraint(equalTo: topAnchor),
            newChatAlertView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newChatAlertView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newChatAlertView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func hideNewConversationAlert() {
        self.newChatAlertView.removeFromSuperview()
    }
}

// MARK: - TextViewEditingDelegate
extension ChatView: TextViewEditingDelegate {
    func didChange() {
        inputTextView.calculateBestHeight()
    }
    
    func beginEditing() {
        if (inputTextView.textColor == .customLightGray) {
            inputTextView.text = ""
            inputTextView.textColor = .black
        }
    }
    
    func endEditing() {
        if (inputTextView.text == "") {
            inputTextView.text = "Aa"
            inputTextView.textColor = .customLightGray
        }
    }
}

// MARK: - KeyboardDelegate
extension ChatView: KeyboardDelegate {
    func showKeyboard() {
        inputContainerBottomAnchor.constant = -self.keyboardFrame.height + Constants.PaddingValues.inputPadding * 2
    }
    
    func hideKeyboard() {
        inputContainerBottomAnchor.constant = 0
    }
}





