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
    
    private let inputTextView = InputTextView()
    private let sendButton = IconButton(systemName: "paperplane.fill")
    
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
    }
    
    private func addSubviews() {
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(sendButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            inputContainerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            inputContainerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: Constants.inputPadding),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: 0),
            inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -(Constants.inputPadding)),
            inputTextView.heightAnchor.constraint(equalToConstant: Constants.inputContainerHeight - (Constants.inputPadding*2)),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.inputPadding),
        ])
        
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: 0),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -(Constants.inputPadding*2)),
            sendButton.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: (Constants.inputPadding*2)),
        ])
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputTextView.calculateBestHeight()
    }
}

