//
//  Constants .swift
//  DatingApp
//
//  Created by Vy Le on 1/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Constants {
    // MARK: Strings
    struct Strings {
        struct NewMessage {
            static let title = "Say something cute!"
            static let message = ""
        }
        struct DeniedLocationAccess {
            static let title = "Location Access"
            static let message = "Please enable location in order to match with other users"
        }
        struct FailLoginWithFacebook {
            static let title = "Unable to login with Facebook"
            static let message = "Please try again..."
        }
        struct Default {
            static let title = "Thank You"
            static let message = "You are now able to see others in the same area"
        }
    }
    
    // MARK: IconNames
    struct IconNames {
        static let back = "chevron.left"
    }

    // MARK: PaddingValues
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
    static let failAnimation = "fail"
    
    static let meterToMile: Double = 1609
    struct NotificationKeys {
        static let selectAddImage = "selectAddImage"
    }
    
    //MARK: - Font size
    static let textSize: CGFloat = 20
}

