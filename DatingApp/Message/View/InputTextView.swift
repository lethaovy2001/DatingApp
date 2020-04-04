//
//  InputTextView.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class InputTextView: UITextView {
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        self.backgroundColor = Constants.Colors.lightGray
        self.layer.cornerRadius = (Constants.PaddingValues.inputContainerHeight - Constants.PaddingValues.inputPadding*2)/2
        self.text = "Aa"
        self.textColor = .lightGray
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textContainerInset = UIEdgeInsets(top: Constants.PaddingValues.inputPadding, left: Constants.PaddingValues.inputPadding, bottom: Constants.PaddingValues.inputPadding, right: Constants.PaddingValues.inputPadding)
            calculateBestHeight()
    }
    
    func calculateBestHeight() {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        if (estimatedSize.height > 150) {
            self.isScrollEnabled = true;
            self.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 6)
            return
        }
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
