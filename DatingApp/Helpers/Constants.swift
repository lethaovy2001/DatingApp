//
//  Constants .swift
//  DatingApp
//
//  Created by Vy Le on 1/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Constants {
    // MARK: Colors
    struct Colors {
        static let fbColor = UIColor(red: 65/225, green: 105/225, blue: 225/225, alpha: 1)
        static let mainBackgroundColor = UIColor(red: 220/225, green: 220/225, blue: 220/225, alpha: 1)
        static let inputContainerColor = UIColor(red: 211/225, green: 211/225, blue: 211/225, alpha: 0.6)
        static let lightGray = UIColor(red: 133/225, green: 146/225, blue: 158/225, alpha: 0.3)
        static let crimson = UIColor(red: 220/225, green: 20/225, blue: 60/225, alpha: 1)
        static let amour = UIColor(red: 238/225, green: 82/225, blue: 83/225, alpha: 1)
        static let orangeRed = UIColor(red: 255/225, green: 69/225, blue: 0/225, alpha: 1)
        //RGB(255, 69, 0)
    }
    
    struct PaddingValues {
        // MARK: Input Container
        static let inputContainerHeight: CGFloat = 60
        static let inputPadding: CGFloat = 12
        static let inputTextViewHeight: CGFloat = 36
        
        // MARK: Swipe
        static let swipeImageCornerRadius = CGFloat(20)
        
        // MARK: Button
        static let likeButtonHeight = CGFloat(70)
    }
    
    // MARK: ID
    static let cellId = "cellId"
    static let messageCellId = "messageCellId"
    
    // MARK: Animation Names
    static let loveAnimation = "loveAnimation"
    static let searchLocationAnimation = "searchLocationAnimation"
    
    static let meterToMile: Double = 1609
    
    
}

