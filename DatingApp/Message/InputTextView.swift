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
        self.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        self.layer.cornerRadius = (Constants.inputContainerHeight - Constants.inputPadding*2)/2
        self.text = "I was thinking about youuu oh lalaala ye"
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textContainerInset = UIEdgeInsets(top: Constants.inputPadding, left: Constants.inputPadding, bottom: Constants.inputPadding, right: Constants.inputPadding)
            calculateBestHeight()
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
