//
//  Authentication.swift
//  DatingApp
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

protocol Authentication {

}

protocol UserCreatable: Authentication {
    func createUser()
}
