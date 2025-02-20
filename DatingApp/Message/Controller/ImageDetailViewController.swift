//
//  ImageDetailViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    private var imageView = CustomImageView(imageName: "user", cornerRadius: 0)
    private var exitButton = CustomButton(imageName: "multiply", size: 20, color: .white, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addGesture()
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        exitButton.addTarget(self, action: #selector(handleTapGesture), for: .touchUpInside)
    }
    
    private func addSubviews(){
        view.addSubview(imageView)
        view.addSubview(exitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
        ])
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        imageView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handleTapGesture() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
    
    @objc func handlePinchGesture(gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.transform = gestureView.transform.scaledBy(
            x: gesture.scale, y: gesture.scale
        )
        gesture.scale = 1
    }
}

extension ImageDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
