//
//  AutoSwipeDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol AutoSwipeDelegate {
    func swipe(direction: SwipeDirection)
}

enum SwipeDirection {
    case left
    case right
}
