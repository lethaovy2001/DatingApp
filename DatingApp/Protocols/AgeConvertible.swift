//
//  AgeConvertible.swift
//  DatingApp
//
//  Created by Vy Le on 5/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol AgeConvertible {
    func convertToAge(from birthday: Date) -> Int
}

extension AgeConvertible {
    func convertToAge(from birthday: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let today = calendar.startOfDay(for: Date())
        let dateOfBirth = calendar.startOfDay(for: birthday)
        let components = calendar.dateComponents([.year], from: dateOfBirth, to: today)
        let age = components.year!
        return age
    }
}

