//
//  ScrollImageViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Hero

class ScrollingImageViewController: UIViewController {
    var imageView = CustomImageView(imageName: "Vy.jpg", cornerRadius: 0)
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.hero.isEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.heroID = "image"
        imageView.heroModifiers = [.arc]
    }
    
    private func setup() {
        addSubviews()
        setupConstraints()
        addTapGesture()
    }
    
    private func addSubviews(){
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        self.navigationController?.popViewController(animated: false)
    }
}

