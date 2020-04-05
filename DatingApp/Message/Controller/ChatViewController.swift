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
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        setupUI()
        setupKeyboardObservers()
        registerCellId()
        chatView.addDelegate(uiViewController: self)
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Setup
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
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy, scale: .large)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.layer.addShadow(withDirection: .bottom)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "flag.fill", withConfiguration: boldConfig)?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(reportPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left", withConfiguration: boldConfig)?.withTintColor(.orange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        chatView.setupTitleNavBar(navItem: self.navigationItem)
    }
    
    private func registerCellId() {
        chatView.collectionView.register(ChatCell.self, forCellWithReuseIdentifier: Constants.cellId)
    }
    
    //TODO: Report User
    @objc func reportPressed(){
        
    }
    
    @objc func backPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UICollectionView
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

//MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //inputTextView.calculateBestHeight()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if (inputTextView.textColor == .lightGray) {
//            inputTextView.text = ""
//            inputTextView.textColor = .black
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        if (inputTextView.text == "") {
//            inputTextView.text = "Aa"
//            inputTextView.textColor = .lightGray
//        }
    }
}

//MARK: Keyboards
extension ChatViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue

        //inputContainerBottomAnchor.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {

        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue

        //inputContainerBottomAnchor.constant = -keyboardFrame!.height + Constants.PaddingValues.inputPadding*2
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

