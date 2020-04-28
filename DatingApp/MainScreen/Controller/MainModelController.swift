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
    private var user = UserModel(name: "Unknown", birthday: Date(), work: "Unknown workplace", bio: "No bio", gender: "Female", images: [UIImage()])
    
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
    
    func getData(_ completion : @escaping(UserModel)->()) {
        firebaseService.getUserInfoFromDatabase({ values in
            self.firebaseService.getUserImagesFromDatabase({ images in
                if let birthday = values["birthday"] as? Timestamp {
                    let date = self.firebaseService.convertToDate(timestamp: birthday)
                    let user = UserModel(name: values["first_name"] as! String, birthday: date, work: values["work"] as! String, bio: values["bio"] as! String, gender: values["gender"] as! String, images: images)
                    self.user = user
                    completion(user)
                }
            })
        })
    }
    
    func getAllUsers(_ completion : @escaping()->()){
        var usersData: [UserModel] = []
        firebaseService.getAllUsersFromDatabase { users in
            for user in users {
                guard let bithday = user.value["birthday"] as? Timestamp else { return }
                guard let name = user.value["first_name"] as? String else { return }
                guard let work = user.value["work"] as? String else { return }
                guard let bio = user.value["bio"] as? String else { return }
                guard let gender = user.value["gender"] as? String else { return }
                guard let images = [UIImage(named: "Vy.jpg")] as? [UIImage] else { return }
                let date = self.firebaseService.convertToDate(timestamp: bithday)
                let userModel = UserModel(name: name, birthday: date, work: work, bio: bio, gender: gender, images: images)
                usersData.append(userModel)
                self.users = usersData
                completion()
            }
        }
    }
}
