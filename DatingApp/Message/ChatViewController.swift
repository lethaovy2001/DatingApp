//
//  ChatViewController.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextViewDelegate {
    
    private let inputContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.LIGHTGRAY
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let inputTextView = InputTextView()
    private let sendButton = IconButton(systemName: "paperplane.fill")
    private var inputContainerBottomAnchor: NSLayoutConstraint?
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        setup()
    }
    
    //MARK: Setup
    private func setup() {
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()

        inputTextView.delegate = self
        setupKeyboardObservers()
    }
    
    private func addSubviews() {
        view.addSubview(inputContainerView)
        view.addSubview(line)
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(sendButton)
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            inputContainerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            inputContainerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: Constants.inputPadding),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -(Constants.inputPadding)),
            inputTextView.heightAnchor.constraint(equalToConstant: Constants.inputContainerHeight - (Constants.inputPadding*2)),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.inputPadding),
        ])
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -(Constants.inputPadding))
        inputContainerBottomAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: -(Constants.inputPadding)),
            sendButton.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: (Constants.inputPadding*2)),
        ])
        
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor),
            line.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            line.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.5)
        ])
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputTextView.calculateBestHeight()
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        inputContainerBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {

        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue

        inputContainerBottomAnchor?.constant = -keyboardFrame!.height + Constants.inputPadding*2
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })

    }
}

