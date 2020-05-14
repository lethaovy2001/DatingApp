//
//  Constants .swift
//  DatingApp
//
//  Created by Vy Le on 1/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Constants {
    struct PaddingValues {
        // MARK: Input Container
        static let inputContainerHeight: CGFloat = 54
        static let inputPadding: CGFloat = 12
        static let inputTextViewHeight: CGFloat = 36
        
        // MARK: Swipe
        static let swipeImageCornerRadius: CGFloat = 20
        
        // MARK: Button
        static let likeButtonHeight: CGFloat = 70
    }
    
    // MARK: ID
    static let cellId = "cellId"
    static let messageCellId = "messageCellId"
    
    // MARK: Animation Names
    static let loveAnimation = "loveAnimation"
    static let searchLocationAnimation = "searchLocationAnimation"
    static let match = "match"
    
    static let meterToMile: Double = 1609
    struct NotificationKeys {
        static let selectAddImage = "selectAddImage"
    }
    
    //MARK: Font size
    static let textSize: CGFloat = 20
}

