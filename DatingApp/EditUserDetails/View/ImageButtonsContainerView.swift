//
//  ImageButtonContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 4/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ImageButtonsContainerView: UIView {
    
    private let verticalStackView = CustomStackView(axis: .vertical)
    private let horizontalStackView1 = CustomStackView(axis: .horizontal)
    private let horizontalStackView2 = CustomStackView(axis: .horizontal)
    private let addImageButton1 = AddImageButton()
    private let addImageButton2 = AddImageButton()
    private let addImageButton3 = AddImageButton()
    private let addImageButton4 = AddImageButton()
    private let addImageButton5 = AddImageButton()
    private let addImageButton6 = AddImageButton()
    private var selectedButton = AddImageButton()
    private var imageButtons: [AddImageButton] = []
    
    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        appendImageButtons()
        addTagForButtons()
    }
    
    private func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        horizontalStackView1.addArrangedSubview(addImageButton1)
        horizontalStackView1.addArrangedSubview(addImageButton2)
        horizontalStackView1.addArrangedSubview(addImageButton3)
        horizontalStackView2.addArrangedSubview(addImageButton4)
        horizontalStackView2.addArrangedSubview(addImageButton5)
        horizontalStackView2.addArrangedSubview(addImageButton6)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setAddImageSelector(selector: Selector, target: UIViewController) {
        addImageButton1.addTarget(target, action: selector, for: .touchUpInside)
        addImageButton2.addTarget(target, action: selector, for: .touchUpInside)
        addImageButton3.addTarget(target, action: selector, for: .touchUpInside)
        addImageButton4.addTarget(target, action: selector, for: .touchUpInside)
        addImageButton5.addTarget(target, action: selector, for: .touchUpInside)
        addImageButton6.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSelectedButton(sender: UIButton) {
        switch sender.tag {
        case 1:
            selectedButton = addImageButton1
        case 2:
            selectedButton = addImageButton2
        case 3:
            selectedButton = addImageButton3
        case 4:
            selectedButton = addImageButton4
        case 5:
            selectedButton = addImageButton5
        case 6:
            selectedButton = addImageButton6
        default:
            break
        }
    }
    
    func addDelegate(viewController: EditUserDetailsViewController) {
        viewController.imageTapGestureDelegate = self
    }
    
    private func appendImageButtons() {
        imageButtons = [addImageButton1, addImageButton2, addImageButton3, addImageButton4, addImageButton5, addImageButton6]
    }
    
    private func addTagForButtons() {
        for i in 1...6 {
            imageButtons[i-1].tag = i
        }
    }
    
    func getImage() -> UIImage {
        return selectedButton.currentImage ?? UIImage(named: "Vy")!
    }
}

// MARK: TapGestureDelegate
extension ImageButtonsContainerView: ImageTapGestureDelegate {
    func setImage(image: UIImage) {
        selectedButton.setImage(image: image)
    }
}
