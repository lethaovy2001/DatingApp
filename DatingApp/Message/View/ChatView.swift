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
        container.addShadow(withDirection: .top)
        return container
    }()
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .clear //Constants.Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let inputTextView = InputTextView()
    private let sendButton = CustomButton(imageName: "paperplane.fill", size: 20, color: .orange, addShadow: false, cornerRadius: nil)
    private var inputContainerBottomAnchor = NSLayoutConstraint()
    
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
    
    func addDelegate(uiViewController: UIViewController) {
        inputTextView.delegate = uiViewController as? UITextViewDelegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setup()
    }
    
    //MARK: Setup
    private func setup() {
        self.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: target,
            action: selector)
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
//        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(self.dismissKeyboard))
//        self.view.addGestureRecognizer(tapRecognizer)
//        self.view.isUserInteractionEnabled = true
    }
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(inputContainerView)
        addSubview(line)
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(sendButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            inputContainerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            inputContainerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(Constants.PaddingValues.inputPadding))
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.PaddingValues.inputPadding))
        inputContainerBottomAnchor.isActive = true

        let inputTextViewHeight: CGFloat = Constants.PaddingValues.inputContainerHeight - (Constants.PaddingValues.inputPadding*2)

        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: Constants.PaddingValues.inputPadding),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            inputContainerBottomAnchor,
            inputTextView.heightAnchor.constraint(equalToConstant: inputTextViewHeight),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.PaddingValues.inputPadding)
        ])

        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            sendButton.topAnchor.constraint(equalTo: inputTextView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor),
            line.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            line.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
