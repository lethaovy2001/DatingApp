//
//  XCUIElement+Extension.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
