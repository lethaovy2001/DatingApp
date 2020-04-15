//
//  DatabaseDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/13/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol DatabaseDelegate {
    func shouldUpdateDatabase(values: [String: AnyObject])
}
