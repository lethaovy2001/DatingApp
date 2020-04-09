//
//  CustomTextView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    init(text: String) {
        super.init(frame: .zero, textContainer: nil)
        self.font = UIFont.systemFont(ofSize: 18.0)
        self.textColor = UIColor.darkGray
        self.text = text
        self.isScrollEnabled = false
        self.isEditable = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateBestHeight()
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    func calculateBestHeight() {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
