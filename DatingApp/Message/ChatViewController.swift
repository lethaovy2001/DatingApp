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
        
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -(Constants.inputPadding*2)),
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
}

