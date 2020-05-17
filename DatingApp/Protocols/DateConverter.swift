//
//  DateConverter.swift
//  DatingApp
//
//  Created by Vy Le on 5/17/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol DateConverter {
    func convertToDate(dateString: String) -> Date
}

extension DateConverter {
    func convertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}
