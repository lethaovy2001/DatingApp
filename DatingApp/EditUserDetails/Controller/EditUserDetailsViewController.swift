//
//  EditUserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsViewController: UIViewController {
    // MARK: - Properties
    private let editUserDetailsView = EditUserDetailsView()
    private let database: Database
    private let auth: Authentication
    var user: UserModel?
    var textViewEditingDelegate: TextViewEditingDelegate?
    var tapGestureDelegate: ImageTapGestureDelegate?
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared, database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setSelectors()
        if let userModel = user {
            editUserDetailsView.viewModel = UserDetailsViewModel(model: userModel)
        }
        editUserDetailsView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        editUserDetailsView.addDelegate(viewController: self)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(editUserDetailsView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            editUserDetailsView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editUserDetailsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            editUserDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            editUserDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setSelectors() {
        editUserDetailsView.setLogoutSelector(selector: #selector(logoutPressed), target: self)
        editUserDetailsView.setSaveSelector(selector: #selector(saveButtonPressed), target: self)
        editUserDetailsView.setBackSelector(selector: #selector(backPressed), target: self)
        editUserDetailsView.setAddImageSelector(selector: #selector(addImageButtonPressed), target: self)
    }
    
    // MARK: Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func logoutPressed() {
        auth.logout()
        let vc = LoginViewController(authentication: auth, database: database)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func saveButtonPressed() {
        if let bio = editUserDetailsView.getBioText(),
            let work = editUserDetailsView.getWorkText(),
            let images = editUserDetailsView.getImages() {
            user?.bio = bio
            user?.work = work
            user?.images = images
            if let userModel = user {
                database.saveProfile(ofUser: userModel)
                database.uploadUserImages(images: images) {
                    let vc = UserDetailsViewController()
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
    
    @objc private func addImageButtonPressed(sender: UIButton) {
        editUserDetailsView.setSelectedButton(sender: sender)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self 
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension EditUserDetailsViewController: UITextViewDelegate {
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

// MARK: - UIImagePickerControllerDelegate
// MARK: UINavigationControllerDelegate
extension EditUserDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            tapGestureDelegate?.setImage(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

