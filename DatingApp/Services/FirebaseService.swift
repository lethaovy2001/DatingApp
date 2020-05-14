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
    
    func getUserWithId(id: String,_ completion : @escaping([String: Any])->()) {
        database.collection("users").document(id).addSnapshotListener {
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
    }
    
    func getAllUsersFromDatabase(_ completion : @escaping([String: [String: Any]])->()) {
        //self.updateListOfUsers()
        if let uid = Auth.auth().currentUser?.uid {
            database.collection("users").document(uid).collection("available-users").whereField("hasDisplay", isEqualTo: false).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var data: [String: [String: Any]] = [:]
                    var index = 0
                    for document in querySnapshot!.documents {
                        if (uid != document.documentID) {
                            self.getUserWithId(id: document.documentID, { user in
                                data.updateValue(user, forKey: document.documentID)
                                index += 1
                                if (index == querySnapshot!.documents.count) {
                                    completion(data)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    //TODO: update when first create user
    func updateListOfUsers() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if (uid != document.documentID) {
                        self.database.collection("users").document(uid).collection("available-users").document(document.documentID).setData(["hasDisplay": false, "id": document.documentID], merge: true)
                    }
                }
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
                self.updateListOfUsers()
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
    
    func uploadMessageVideoOntoStorage(url: URL, completion: @escaping ([String: Any]) -> ()) {
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
                            var data = imageData
                            data.updateValue(downloadURL, forKey: "videoUrl")
                            completion(data)
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
    
    func uploadMessageImageOntoStorage(image: UIImage, _ completion: @escaping ([String: Any]) -> ()) {
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
                    completion(properties)
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
    
    func getUserImagesFromDatabase(from id: String, _ completion : @escaping([UIImage])->()) {
        database.collection("profile_images").document(id).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                completion([])
                return
            }
            self.downloadImages(data: data, { images in
                completion(images)
            })
        }
    }
    
    func getMainUserImage(from id: String, _ completion : @escaping(UIImage?)->()) {
        database.collection("profile_images").document(id).addSnapshotListener {
            documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                completion(UIImage())
                return
            }
            
            if let url = data["image0"] as? String {
                self.downloadImageFromStorage(url: url, { image in
                    completion(image)
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
                if let data = data {
                    let image = UIImage(data: data)!
                    completion(image)
                }
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

// MARK: List of Messages
extension FirebaseService {
    func getListMessages(_ completion: @escaping([String])->()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database.collection("user-messages").document(uid).collection("match-users").order(by: "time").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data: [String] = []
                for document in querySnapshot!.documents {
                    data.append(document.documentID)
                }
                print("Sucessful get users document!")
                completion(data)
            }
        }
    }
}


// MARK: Messages
extension FirebaseService {
    func saveMessageToDatabase(with message: Message,_ completion : @escaping(String)->()) {
        guard let data = message.getMessageDictionary() else { return }
        var ref: DocumentReference? = nil
        ref = database.collection("messages").addDocument(data: data, completion: { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(ref!.documentID)
            }
        })
    }
    
    func updateMessageReference(toId: String, messageId: String) {
        if let fromId = Auth.auth().currentUser?.uid {
            let data: [String : Any] = [messageId: 1, "date": Date()]
            database.collection("user-messages").document(fromId).collection("match-users").document(toId).collection("messageId").document(messageId).setData(data, merge: true, completion: { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Successfully update message reference")
                }
            })
            database.collection("user-messages").document(toId).collection("match-users").document(fromId).collection("messageId").document(messageId).setData(data, merge: true, completion: { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Successfully update message reference")
                }
            })
        }
    }
    
    func getMessageDetails(with messageId: String, _ completion : @escaping([String: Any])->()) {
        database.collection("messages").document(messageId).getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            completion(data)
        }
    }
    
    func getLastestMessage(toId: String, _ completion : @escaping(String)->()) {
        if let fromId = Auth.auth().currentUser?.uid {
            database.collection("user-messages").document(fromId).collection("match-users").document(toId).collection("messageId").order(by: "date", descending: true).addSnapshotListener() {
                querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                for document in snapshot.documentChanges {
                    print(document.document.data())
                    if document.type == .added {
                        completion(document.document.documentID)
                        break
                    }
                }
            }
        }
    }
    
    func getMessages(toId: String, _ completion : @escaping([String: Any])->()) {
        if let fromId = Auth.auth().currentUser?.uid {
            database.collection("user-messages").document(fromId).collection("match-users").document(toId).collection("messageId").addSnapshotListener() {
                querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                if snapshot.isEmpty {
                    completion([:])
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

extension FirebaseService {
    func updateMatchUser(toId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // match both user
        database.collection("users").document(toId).collection("available-users")
            .whereField("id", isEqualTo: uid)
            .whereField("hasDisplay", isEqualTo: true).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for _ in querySnapshot!.documents {
                        self.database.collection("user-messages").document(uid).collection("match-users").document(toId).setData(["isMatch": true, "time": Date()], merge: true)
                        self.database.collection("user-messages").document(toId).collection("match-users").document(uid).setData(["isMatch": true, "time": Date()], merge: true)
                    }
                }
        }
        // save when one person like first
        database.collection("users").document(uid).collection("available-users").document(toId).setData(["hasDisplay": true], merge: true)
    }
    
    func deleteDislikedUser(toId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database.collection("users").document(uid).collection("available-users").document(toId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

