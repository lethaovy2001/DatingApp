//
//  UITextView+helper.swift
//  DatingApp
//
//  Created by Vy Le on 4/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension UITextView {
    func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.textSize)], context: nil)
    }
}
