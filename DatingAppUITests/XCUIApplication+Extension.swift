//
//  XCUIApplication+Extension.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
extension XCUIApplication {
    var isDisplayingEmailLogin: Bool {
        return otherElements["emailLoginView"].exists
    }
    
    var isDisplayingLogin: Bool {
        return otherElements["loginView"].exists
    }
    
    var isDisplayingMain: Bool {
        return otherElements["mainView"].exists
    }
    
    var isDisplayingSignUp: Bool {
        return otherElements["signUpView"].exists
    }
    
    var isDisplayingAppLogo: Bool {
        return otherElements["appLogo"].exists
    }
    
    var isDisplayingSearchingAnimation: Bool {
        return otherElements["SearchingAnimation"].exists
    }
}


