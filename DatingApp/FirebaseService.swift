//
//  FirebaseService.swift
//  DatingApp
//
//  Created by Vy Le on 4/17/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FirebaseService {
    private var database: Firestore!
    private var storage: Storage!
    
    init() {
        database = Firestore.firestore()
        storage = Storage.storage()
    }
    
    func getUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func getUserInfoFromDatabase(_ completion : @escaping([String: Any])->()) {
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("users").document(uid).addSnapshotListener {
                documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("Current data: \(data)")
                completion(data)
            }
        } else {
            print("*** FirebaseService: User ID is nil")
        }
    }
    
    func getAllUsersFromDatabase(_ completion : @escaping([String: [String: Any]])->()) {
        database.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data: [String: [String: Any]] = [:]
                for document in querySnapshot!.documents {
                    if (Auth.auth().currentUser?.uid != document.documentID) {
                        data.updateValue(document.data(), forKey: document.documentID)
                    }
                }
                print("Sucessful get users document!")
                completion(data)
            }
        }
    }
    
    func convertToDate(timestamp: Timestamp) -> Date {
        return timestamp.dateValue()
    }
    
    func updateDatabase(with data: [String: Any]) {
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("users").document(uid).updateData(data, completion: { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            })
        }
    }
}

// MARK: Authentication
extension FirebaseService {
    func authenticateWithFirebase(accessToken: String,_ completion: @escaping()->()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                print(String(describing: error))
                return
            }
            print("Successfully log user into firebase")
            completion()
        }
    }
    
    func createUser(email: String, password: String, _ completion: @escaping()->()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (authResult, error) in
            if error != nil {
                print("***** Unable to authenticate with Firebase email: \(String(describing: error))")
                return
            }
            self.authenticateUsingEmail(email: email, password: password, {
                self.updateDatabase(with: ["first_name": "A"])
            })
        })
    }
    
    func authenticateUsingEmail(email: String, password: String,_ completion: @escaping()->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authResult, error) in
            if error != nil {
                print(String(describing: error))
                return
            }
            print("Successfully log user into firebase")
            completion()
        })
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: Storage
extension FirebaseService {
    func updateImageDatabase(with data: [String: Any]) {
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("profile_images").document(uid).setData(data, merge: true)
        }
    }
    
    func uploadImages(images: [UIImage]){
        if let uid = Auth.auth().currentUser?.uid {
            var index = 0
            for image in images {
                uploadImageOntoStorage(image: image, uid: uid, index: index)
                index += 1
            }
        }
    }
    
    func uploadImageOntoStorage(image: UIImage, uid: String, index: Int) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child(uid).child("\(imageName).jpg")
        if let uploadData = image.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url?.absoluteString else {
                        print("FirebaseService: error in downloadURL")
                        return
                    }
                    let data = ["image\(index)": downloadURL]
                    self.updateImageDatabase(with: data)
                }
            }
        }
    }
    
    func getUserImagesFromDatabase(_ completion : @escaping([UIImage?])->()) {
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("profile_images").document(uid).addSnapshotListener {
                documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    completion([])
                    print("Document data was empty.")
                    return
                }
                
                self.downloadImages(data: data, { images in
                    completion(images)
                })
            }
        } else {
            print("*** FirebaseService: User ID is nil")
        }
    }
    
    func getUserImagesFromDatabase(from id: String, _ completion : @escaping([UIImage?])->()) {
        database.collection("profile_images").document(id).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                completion([])
                return
            }
            self.downloadImages(data: data, { images in
                completion(images)
            })
        }
        
    }
    
    func downloadImages(data: [String: Any], _ completion : @escaping([UIImage])->()) {
        var imageTemp: [UIImage] = []
        var index = 0
        for imageName in data {
            if let url = data[imageName.key] as? String {
                self.downloadImageFromStorage(url: url, { downloadedImage in
                    imageTemp.append(downloadedImage)
                    index += 1
                    if (index == data.count) {
                        completion(imageTemp)
                    }
                })
            }
        }
    }
    
    func downloadImageFromStorage(url: String,_ completion : @escaping(UIImage)->()) {
        let httpsReference = storage.reference(forURL: url)
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("FirebaseService: downloadImage \(error)")
            } else {
                let image = UIImage(data: data!)!
                completion(image)
            }
        }
    }
}
