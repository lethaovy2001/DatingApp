//
//  MainModelController.swift
//  DatingApp
//
//  Created by Duy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation

class MainModelController {
    private var users = [SwipeCardModel]()
    
    func getUsers() -> [SwipeCardModel] {
        return users
    }
    
    func getMockImageNames() -> [String] {
        let userImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]
        return userImages
    }
    
    func getMockUsers() -> [SwipeCardModel] {
        let userImages = getMockImageNames()
        
        return [
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]])]
    }
}
