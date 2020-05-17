//
//  ImageTapGestureDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/23/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol ImageTapGestureDelegate {
    func didTap()
    func setImage(image: UIImage)
}

extension ImageTapGestureDelegate {
    func didTap() {
        print("Did Tap...")
    }
    
    func setImage(image: UIImage) {
        print("Set Image...")
    }
}
