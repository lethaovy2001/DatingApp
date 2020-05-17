//
//  EditUserDetailsViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/6/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsViewController: UIViewController {
    private let editUserDetailsView = EditUserDetailsView()
    private var viewModel: UserDetailsViewModel
    let firebaseService = FirebaseService()
    var textViewEditingDelegate: TextViewEditingDelegate?
    var imageTapGestureDelegate: TapGestureDelegate?
    
    // MARK: Init
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        editUserDetailsView.viewModel = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        editUserDetailsView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        editUserDetailsView.addDelegate(viewController: self)
        setSelectors()
    }
    
    // MARK: Setup
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
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutPressed() {
        firebaseService.logout()
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func saveButtonPressed() {
        saveData()
    }
    
    @objc func addImageButtonPressed(sender: UIButton) {
        editUserDetailsView.setSelectedButton(sender: sender)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self 
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: UITextViewDelegate
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

extension EditUserDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            imageTapGestureDelegate?.setImage(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditUserDetailsViewController: WritableDatabase {
    func saveData() {
        if let bio = editUserDetailsView.getBioText(),
            let work = editUserDetailsView.getWorkText(),
            let images = editUserDetailsView.getImages() {
            let dictionary: [String: Any] = [
                "bio": bio,
                "work": work,
            ]
            updateUser(info: dictionary)
            updateUserImages(images: images)
            let vc = UserDetailsViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            //TODO: Alert view when user haven't fill out all fields
        }
    }
}

