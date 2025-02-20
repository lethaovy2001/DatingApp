//
//  InputTextView.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class InputTextView: UITextView {
    private var isScrollable: Bool!
    
    init(placeholder: String, cornerRadius: CGFloat, isScrollable: Bool) {
        super.init(frame: .zero, textContainer: nil)
        self.backgroundColor = UIColor.inputContainerColor
        self.layer.cornerRadius = cornerRadius
        self.text = placeholder
        self.textColor = .customLightGray
        self.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.isScrollEnabled = false
        self.autocorrectionType = .no
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isScrollable = isScrollable
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textContainerInset = UIEdgeInsets(top: Constants.PaddingValues.inputPadding, left: Constants.PaddingValues.inputPadding, bottom: Constants.PaddingValues.inputPadding, right: Constants.PaddingValues.inputPadding)
            calculateBestHeight()
    }
    
    func setText(text: String) {
        self.text = text
        self.textColor = .darkGray
    }
    
    func hasText() -> Bool {
        if (self.textColor == .customLightGray) {
            return false
        }
        return true
    }
    
    func calculateBestHeight() {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        if (self.isScrollable) {
            if (estimatedSize.height > 150) {
                self.isScrollEnabled = true
                self.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 6)
                return
            }
        }
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
