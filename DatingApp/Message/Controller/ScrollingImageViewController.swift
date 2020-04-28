//
//  ScrollingImageViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ScrollingImageViewController: UIViewController {
    private var imageView = CustomImageView(imageName: "Vy.jpg", cornerRadius: 0)
    private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = false
        sv.alwaysBounceHorizontal = false
        sv.showsVerticalScrollIndicator = true
        sv.isScrollEnabled = true
        sv.flashScrollIndicators()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 10.0
        return sv
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        scrollView.delegate = self
    }
    
    //MARK: Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addGesture()
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        imageView.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTapGesture() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self.view)
        let centerOfParentContainer = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        imageView.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        UIView.animate(withDuration: 0.1) {
            self.imageView.center = CGPoint(x: centerOfParentContainer.x + point.x,
                                            y: centerOfParentContainer.y + point.y)
        }
    }
}

// MARK: UIScrollViewDelegate
extension ScrollingImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
