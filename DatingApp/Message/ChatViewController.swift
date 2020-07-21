//
//  ChatViewController.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ChatViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Properties
    private let chatView: ChatView = {
        let view = ChatView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let modelController: ChatModelController
    private let database: Database
    private let auth: Authentication
    var textViewEditingDelegate: TextViewEditingDelegate?
    var keyboardDelegate: KeyboardDelegate?
    var user: UserModel? {
        didSet {
            if let userModel = user {
                chatView.viewModel = UserDetailsViewModel(model: userModel)
                modelController.user = userModel
            }
        }
    }
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared, database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        self.modelController = ChatModelController(database: database)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getMessages()
        view.accessibilityIdentifier = "chatView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        registerCellId()
        setupSelectors()
        chatView.addDelegate(viewController: self)
        chatView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        chatView.collectionView.delegate = self
        chatView.collectionView.dataSource = self
    }
    
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
        modelController.getMessagesFromDatabase() {
            DispatchQueue.main.async {
                self.chatView.collectionView.reloadData()
                let indexPath = IndexPath(item: self.modelController.getMessages().count - 1, section: 0)
                self.chatView.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
                if self.modelController.getMessages().count == 0 {
                    self.chatView.showNewConversationAlert()
                }
                self.chatView.doneLoading()
            }
        }
    }
    
    func setupSelectors() {
        chatView.setBackButtonSelector(selector: #selector(backPressed), target: self)
        chatView.setAddImageButtonSelector(selector: #selector(addImageButtonPressed), target: self)
        chatView.setSendButtonSelector(selector: #selector(sendButtonPressed), target: self)
        chatView.setDoneSelector(selector: #selector(doneButtonPressed), target: self)
    }
    
    // MARK: Actions
    @objc private func backPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendButtonPressed(){
        if let fromId = auth.getCurrentUserId(),
        let text = chatView.getInputText(),
        let toId = user?.id {
            let messageInfo: [String: Any] = [
                "fromId": fromId,
                "toId": toId,
                "time": Date(),
                "text": text
            ]
            let message = Message(dictionary: messageInfo)
            database.saveMessage(message: message)
            chatView.setEmptyInputText()
        }
    }
    
    @objc private func addImageButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func doneButtonPressed() {
        self.chatView.hideNewConversationAlert()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelController.getMessages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ChatCell
        if let uid = auth.getCurrentUserId(),
            let image = user?.mainImage {
            let message = modelController.getMessages()[indexPath.item]
            let viewModel = MessageViewModel(model: message, currentUserId: uid, userImage: image)
            viewModel.configure(cell)
            if let videoUrlString = viewModel.videoUrl,
                let url = URL(string: videoUrlString) {
                cell.videoURL = url
            }
        }
        cell.tapDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        let message = modelController.getMessages()[indexPath.item]
        if let text = message.text {
            height = estimatedFrameForText(text: text).height + 20
        } else if let imageWidth = message.imageWidth, let imageHeight = message.imageHeight {
            height = CGFloat(imageHeight) / CGFloat(imageWidth) * 200
        }
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textSize)], context: nil)
    }
}

// MARK: - UITextViewDelegate
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

// MARK: - Keyboards
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            handleVideoSelectedForUrl(videoUrl)
        } else {
            handleImageSelectedForInfo(info)
        }
        dismiss(animated: true, completion: nil)
        dismissKeyboard()
        self.view.layoutIfNeeded()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Images and Videos
extension ChatViewController {
    private func handleVideoSelectedForUrl(_ url: URL) {
        guard
            let fromId = auth.getCurrentUserId(),
            let toId = user?.id
        else { return }
        let dictionary: [String: Any] = [
            "fromId": fromId,
            "toId": toId
        ]
        let message = Message(dictionary: dictionary)
        database.uploadVideoMessage(url: url, message: message)
    }
    
    private func handleImageSelectedForInfo(_ info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            guard
                let fromId = auth.getCurrentUserId(),
                let toId = user?.id
            else { return }
            let dictionary: [String: Any] = [
                "fromId": fromId,
                "toId": toId,
            ]
            var message = Message(dictionary: dictionary)
            message.image = selectedImage
            database.uploadImageMessage(message: message)
        }
    }
}

// MARK: - ZoomTapDelegate
extension ChatViewController: ZoomTapDelegate {
    func didTap(on imageView: UIImageView) {
        let vc = ImageDetailViewController()
        if let image = imageView.image {
            vc.image = image
        }
        self.navigationController?.pushViewController(vc, animated: false)
        dismissKeyboard()
    }
}

// MARK: - TapGestureDelegate
extension ChatViewController: ImageTapGestureDelegate {
    func didTap() {
        let vc = UserDetailsViewController()
        if let model = user {
            vc.viewModel = UserDetailsViewModel(model: model)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


