//
//  MainModelController.swift
//  DatingApp
//
//  Created by Duy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation
import Firebase

class MainModelController {
    private var firebaseService = FirebaseService()
    private var users = [UserModel]()
    private var user = UserModel(info: ["":""])
    
    func getUsers() -> [UserModel] {
        return users
    }
    
    func getUserInfo() -> UserModel {
        return user
    }
    
    func getMockImageNames() -> [String] {
        let userImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]
        return userImages
    }
    
    func getMockImage() -> [UIImage] {
        var userImages: [UIImage] = []
        for imageName in getMockImageNames() {
            userImages.append(UIImage(named: imageName)!)
        }
        return userImages
    }
    
    func update(data: Any?) {
        let dictionary = data as! NSDictionary
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        if let firstName = dictionary["first_name"] as? String,
            let gender = dictionary["gender"] as? String,
            let birthday = dictionary["birthday"] as? String {
            if let date = dateFormatter.date(from: birthday) {
                let data: [String: Any] = ["first_name": firstName, "gender": gender, "birthday": date]
                firebaseService.updateDatabase(with: data)
            }
        } else {
            print("*** MainModelController: Unable to update()")
        }
    }
    
    func getData(_ completion : @escaping()->()) {
        firebaseService.getUserInfoFromDatabase({ values in
            self.firebaseService.getUserImagesFromDatabase({ images in
                if let birthday = values["birthday"] as? Timestamp {
                    let date = self.firebaseService.convertToDate(timestamp: birthday)
                    let data: [String: Any?] =
                        ["first_name": values["first_name"],
                         "work": values["work"],
                         "bio": values["bio"],
                         "gender": values["gender"],
                         "birthday": date,
                         "images": images]
                    let user = UserModel(info: data)
                    self.user = user
                    completion()
                }
            })
        })
    }
    
    func getAllUsers(_ completion : @escaping()->()){
        var usersData: [UserModel] = []
        firebaseService.getAllUsersFromDatabase { users in
            for user in users {
                let userModel = UserModel(info: user.value)
                usersData.append(userModel)
                self.users = usersData
                completion()
            }
        }
    }
}
