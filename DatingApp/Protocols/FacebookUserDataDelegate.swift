//
//  FacebookLoginDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol FacebookUserDataDelegate {
    func getUserInfo(values: [String: AnyObject])
}
