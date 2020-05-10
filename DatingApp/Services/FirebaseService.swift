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
import AVFoundation

class FirebaseService {
    private var database: Firestore!
    private var storage: Storage!
    
    init() {
        database = Firestore.firestore()
        storage = Storage.storage()
    }
    
    func getUserID() -> String? {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        }
        return nil
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
                    data.updateValue(document.data(), forKey: document.documentID)
                }
                print("Sucessful get users document!")
                completion(data)
            }
        }
    }
    
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
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.synchronize()
            print("Successfully logout of Firebase")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
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

// MARK: Storage
extension FirebaseService {
    // MARK: User Profile Images
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
        if let uploadData = image.jpegData(compressionQuality: 1.0) {
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
    
    func uploadMessageVideoOntoStorage(url: URL, completion: @escaping (Message) -> ()) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("messages-videos").child("\(imageName).mov")
         if let videoData = NSData(contentsOf: url) as Data? {
            let uploadTask = storageRef.putData(videoData, metadata: nil) { (metadata, error) in
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url?.absoluteString else {
                        print("FirebaseService: error in downloadURL")
                        return
                    }
                    guard let fileUrl = url else {
                        print("FirebaseService: error in fileUrl")
                        return
                    }
                    
                    if let thumbnailImage = self.thumbnailImageForFileUrl(fileUrl) {
                        self.uploadMessageImageOntoStorage(image: thumbnailImage, { imageData in
                            var data = imageData.getMessageDictionary()
                            data.updateValue(downloadURL, forKey: "videoUrl")
                            let message = Message(dictionary: data, image: thumbnailImage)
                            completion(message)
                        })
                    }
                }
            }
            uploadTask.observe(.success) { (snapshot) in
                print("Success")
            }
        }
    }
    
    private func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
            
        } catch let err {
            print(err)
        }
        
        return nil
    }
    
    func uploadMessageImageOntoStorage(image: UIImage, _ completion: @escaping (Message) -> ()) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("messages-images").child("\(imageName).jpg")
        if let uploadData = image.jpegData(compressionQuality: 1.0) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url?.absoluteString else {
                        print("FirebaseService: error in downloadURL")
                        return
                    }
                    let properties: [String: Any] = ["imageUrl": downloadURL as String, "imageWidth": image.size.width, "imageHeight": image.size.height]
                    let message = Message(dictionary: properties, image: image)
                    completion(message)
                }
            }
        }
    }
    
    func getUserImagesFromDatabase(_ completion : @escaping([UIImage])->()) {
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("profile_images").document(uid).addSnapshotListener {
                documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
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
}

// MARK: Messages
extension FirebaseService {
    func saveMessageToDatabase(with message: Message,_ completion : @escaping(String)->()) {
//        if let uid = Auth.auth().currentUser?.uid {
//            var values: [String: Any] = ["fromId": uid, "time": Date()]
//            data.forEach({values[$0] = $1})
            var ref: DocumentReference? = nil
        ref = database.collection("messages").addDocument(data: message.getMessageDictionary(), completion: { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    completion(ref!.documentID)
                }
            })
        //}
    }
    
    func updateMessageReference(toId: String, messageId: String) {
        if let fromId = Auth.auth().currentUser?.uid {
            let data = [messageId: 1]
            database.collection("user-messages").document(fromId).collection(toId).document(messageId).setData(data, merge: true, completion: { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Successfully update message reference")
                }
            })
        }
    }
    
    func getMessageDetails(with messageId: String, _ completion : @escaping(Message)->()) {
        database.collection("messages").document(messageId).getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            let message = Message(dictionary: data)
            completion(message)
        }
    }
    
    func getMessages(toId: String, _ completion : @escaping([String: Any])->()) {
        if let fromId = Auth.auth().currentUser?.uid {
            database.collection("user-messages").document(fromId).collection(toId).addSnapshotListener() {
                querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                for diff in snapshot.documentChanges {
                    print(diff.document.data())
                    if (diff.type == .added) {
                        completion(diff.document.data())
                    }
                }
            }
        }
    }
}

