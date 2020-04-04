//
//  SwipeCardModel.swift
//  DatingApp
//
//  Created by Vy Le on 2/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct SwipeCardModel {
    var name: String
    var age : Int
    var imageName : [String]
      
    init(name: String, age: Int, imageName: [String]) {
        self.name = name
        self.age = age
        self.imageName = imageName
    }
}
