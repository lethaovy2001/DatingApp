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
    private let modelController = ChatModelController()
    var textViewEditingDelegate: TextViewEditingDelegate?
    var keyboardDelegate: KeyboardDelegate?
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObservers()
        registerCellId()
        setupSelectors()
        chatView.addDelegate(viewController: self)
        chatView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
        getMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    private func registerCellId() {
        chatView.collectionView.register(ChatCell.self, forCellWithReuseIdentifier: Constants.cellId)
    }
    
    private func getMessages() {
        modelController.getMessagesFromDatabase {
            DispatchQueue.main.async {
                self.chatView.collectionView.reloadData()
                let indexPath = IndexPath(item: self.modelController.getMessages().count - 1, section: 0)
                self.chatView.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func setupSelectors() {
        chatView.setBackButtonSelector(selector: #selector(backPressed), target: self)
        chatView.setAddImageButtonSelector(selector: #selector(addImageButtonPressed), target: self)
        chatView.setSendButtonSelector(selector: #selector(sendButtonPressed), target: self)
    }
    
    // MARK: Actions
    @objc func backPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendButtonPressed(){
        //TODO: Remove mock data
        let message: [String: Any] = [
            "toId": "2",
            "time": Date(),
            "text": chatView.getInputText()
        ]
        modelController.updateMessageToDatabase(message: message)
        chatView.setEmptyInputText()
    }
    
    @objc func addImageButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: UICollectionView
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelController.getMessages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ChatCell
        if let uid = modelController.getCurrentUserId() {
            let message = modelController.getMessages()[indexPath.item]
            cell.viewModel = MessageViewModel(model: message, currentUserId: uid)
        } else {
            //TODO: Alert error
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = modelController.getMessages()[indexPath.item]
        let text = message.text
        let width = UIScreen.main.bounds.width
        let height = estimatedFrameForText(text: text).height + 20
        return CGSize(width: width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
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
        if self.modelController.getMessages().count > 0 {
            let indexPath = IndexPath(item: self.modelController.getMessages().count - 1, section: 0)
            chatView.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    private func performKeyboardAnimation(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


