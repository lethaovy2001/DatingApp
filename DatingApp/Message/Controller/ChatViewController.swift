//
//  ChatViewController.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let chatView: ChatView = {
        let view = ChatView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var textViewEditingDelegate: TextViewEditingDelegate?
    var keyboardDelegate: KeyboardDelegate?
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        setupUI()
        setupKeyboardObservers()
        registerCellId()
        chatView.addDelegate(viewController: self)
        chatView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(chatView)
        NSLayoutConstraint.activate([
            chatView.topAnchor.constraint(equalTo: view.topAnchor),
            chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func addNavigationBar() {
        let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.white
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .large)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.layer.addShadow(withDirection: .bottom)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "flag.fill", withConfiguration: boldConfig)?.withTintColor(UIColor.amour, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(reportPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left", withConfiguration: boldConfig)?.withTintColor(UIColor.amour, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        chatView.setupTitleNavBar(navItem: self.navigationItem)
    }
    
    private func registerCellId() {
        chatView.collectionView.register(ChatCell.self, forCellWithReuseIdentifier: Constants.cellId)
    }
    
    // TODO: Report User
    // MARK: Actions
    @objc func reportPressed(){
        
    }
    
    @objc func backPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionView
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ChatCell
        cell.textView.text = "I love you 3000 \n lala"
        return cell
    }
    
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

// MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewEditingDelegate?.didChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewEditingDelegate?.beginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
         textViewEditingDelegate?.endEditing()
    }
}

// MARK: Keyboards
extension ChatViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        keyboardDelegate?.hideKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        chatView.getKeyboard(frame: keyboardFrame)
        keyboardDelegate?.showKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    private func performKeyboardAnimation(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}


