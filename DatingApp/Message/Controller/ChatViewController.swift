//
//  ChatViewController.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatViewController: UICollectionViewController {
    
    private let inputContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let inputTextView = InputTextView()
    private let sendButton = CustomButton(imageName: "paperplane.fill", size: 20, color: .red, addShadow: false, cornerRadius: nil)
    private var inputContainerBottomAnchor = NSLayoutConstraint()
    
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        sendButton.backgroundColor = .yellow
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Setup
    private func setup() {
        setupCollectionView()
        addSubviews()
        setUpConstraints()
        setupKeyboardObservers()
        addTapGesture()
        addDelegate()
    }
    
    private func setupCollectionView() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: Constants.cellId)
        self.collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    private func addDelegate() {
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
            inputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        inputContainerBottomAnchor = inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.PaddingValues.inputPadding))
        
        let inputTextViewHeight: CGFloat = Constants.PaddingValues.inputContainerHeight - (Constants.PaddingValues.inputPadding*2)
        
        NSLayoutConstraint.activate([
            inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: Constants.PaddingValues.inputPadding),
            inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            inputContainerBottomAnchor,
            inputTextView.heightAnchor.constraint(equalToConstant: inputTextViewHeight),
            inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: Constants.PaddingValues.inputPadding),
        ])
        
        NSLayoutConstraint.activate([
            sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.inputContainerHeight),
            sendButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            sendButton.topAnchor.constraint(equalTo: inputTextView.topAnchor)
        ])
        //-(Constants.PaddingValues.inputPadding)
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor),
            line.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor),
            line.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.5)
        ])
    }
    
    private func addTapGesture() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        self.view.isUserInteractionEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ChatCell
        cell.textView.text = "12"
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = "I love you 3000 \n lala"
        let width = UIScreen.main.bounds.width
        let height = estimatedFrameForText(text: text).height + 20
        return CGSize(width: width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        
        let size = CGSize(width: 200, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
}

//MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        inputTextView.calculateBestHeight()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (inputTextView.textColor == .lightGray) {
            inputTextView.text = ""
            inputTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (inputTextView.text == "") {
            inputTextView.text = "Aa"
            inputTextView.textColor = .lightGray
        }
    }
}

//MARK: Keyboards
extension ChatViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        inputContainerBottomAnchor.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {

        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue

        inputContainerBottomAnchor.constant = -keyboardFrame!.height + Constants.PaddingValues.inputPadding*2
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

