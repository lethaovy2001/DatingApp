//
//  TextViewEditingDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol TextViewEditingDelegate {
    func didChange()
    func beginEditing()
    func endEditing()
}


