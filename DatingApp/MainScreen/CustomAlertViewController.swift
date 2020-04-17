//
//  CustomAlertViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    private let customAlertView: CustomAlertView = {
        let view = CustomAlertView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(customAlertView)
        NSLayoutConstraint.activate([
            customAlertView.topAnchor.constraint(equalTo: view.topAnchor),
            customAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customAlertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customAlertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
