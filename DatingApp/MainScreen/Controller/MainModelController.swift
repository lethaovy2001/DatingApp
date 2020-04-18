//
//  MainModelController.swift
//  DatingApp
//
//  Created by Duy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation

class MainModelController {
    private var firebaseService = FirebaseService()
    private var users = [SwipeCardModel]()
    private var user = UserModel(name: "Unknown", birthday: Date(), work: "Unknown workplace", bio: "No bio", gender: "Female")
    
    func getUsers() -> [SwipeCardModel] {
        return users
    }
    
    func getUserInfo() -> UserModel {
        return user
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
    
    func update(data: Any?) {
        let dictionary = data as! NSDictionary
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        if let firstName = dictionary["first_name"] as? String,
            let gender = dictionary["gender"] as? String,
            let birthday = dictionary["birthday"] as? String {
            if let date = dateFormatter.date(from: birthday) {
                let user = UserModel(name: firstName, birthday: date, work: "UW", bio: "", gender: gender)
                self.user = user
            }
            firebaseService.updateDatabase(user: user)
        } else {
            print("*** MainModelController: Unable to update()")
        }
    }
    
    func getData(_ completion : @escaping(UserModel)->()) {
        firebaseService.getUserInfoFromDatabase({ values in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            //if let birthday = values["birthday"] as? TimeInterval {
                
//               
                    let user = UserModel(name: values["first_name"] as! String, birthday: Date(), work: values["work"] as! String, bio: values["bio"] as! String, gender: values["gender"] as! String)
                    self.user = user
                    completion(user)
                
            //}
        })
    }
}
