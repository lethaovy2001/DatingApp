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
    private var auth: Auth!
    static let shared = FirebaseService()
    
    init() {
        database = Firestore.firestore()
        storage = Storage.storage()
        auth = Auth.auth()
    }
    
    private func getListMessage(withId id: String,_ completion: @escaping(ListMessageModel)->()) {
        self.loadUserProfile(withId: id) { user in
            var userModel = user
            self.getMainUserImage(from: id) {
                image in
                if let image = image {
                    userModel.mainImage = image
                }
                self.getLastestMessage(toId: id) { messageId in
                    if messageId == "" {
                        let model = ListMessageModel(user: userModel, message: Message(dictionary: [:]))
                        completion(model)
                    } else {
                        self.getMessageDetails(with: messageId) { messageData in
                            var values = messageData
                            guard let time = messageData["time"] as? Timestamp else { return }
                            let convertedTime = self.convertToDate(timestamp: time)
                            values.updateValue(convertedTime, forKey: "time")
                            let message = Message(dictionary: values)
                            let model = ListMessageModel(user: userModel, message: message)
                            completion(model)
                        }
                    }
                }
            }
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
    
    func updateImageDatabase(with data: [String: Any]) {
        if let uid = auth.currentUser?.uid {
            database.collection("profile_images").document(uid).setData(data, merge: true)
        }
    }
    
    func saveMessageReference(message: Message) {
        if let fromId = auth.currentUser?.uid,
            let data = message.getMessageReference(),
            let toId = message.toId,
            let messageId = message.messageId {
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
    
    func convertToDate(timestamp: Timestamp) -> Date {
        return timestamp.dateValue()
    }
    
    private func getListMessageModelAtIndex(listMessageModel: ListMessageModel, models: [ListMessageModel]) -> Int? {
        var modelIndex = 0
        for model in models {
            if model.user.id == listMessageModel.user.id {
                return modelIndex
            }
            modelIndex += 1
        }
        return nil
    }
}

// MARK: - Storage
extension FirebaseService {
    // MARK: Upload
    func uploadImageOntoStorage(image: UIImage, uid: String, index: Int,_ completion: @escaping()->()) {
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
                    completion()
                }
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
    
    // MARK: Download
    func downloadImageFromStorage(url: String,_ completion : @escaping(UIImage)->()) {
        let httpsReference = storage.reference(forURL: url)
        httpsReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
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

// MARK: - Messages
extension FirebaseService {
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
        if let fromId = auth.currentUser?.uid {
            database.collection("user-messages").document(fromId).collection("match-users").document(toId).collection("messageId").order(by: "date", descending: true).addSnapshotListener() {
                querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                if snapshot.documentChanges.count == 0 {
                    completion("")
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
        if let fromId = auth.currentUser?.uid {
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

// MARK: - Database
extension FirebaseService : Database {
    // MARK: Save data
    func saveProfile(ofUser user: UserModel) {
        if let uid = getCurrentUserId(), let data = user.getUserInfo() {
            database.collection("users").document(uid).setData(data, merge: true)
        }
    }
    
    func saveLikeUser(withId id: String) {
        guard let uid = auth.currentUser?.uid else { return }
        // match both user
        database.collection("users").document(id).collection("available-users")
            .whereField("id", isEqualTo: uid)
            .whereField("hasDisplay", isEqualTo: true).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for _ in querySnapshot!.documents {
                        self.database.collection("user-messages").document(uid).collection("match-users").document(id).setData(["isMatch": true, "time": Date()], merge: true)
                        self.database.collection("user-messages").document(id).collection("match-users").document(uid).setData(["isMatch": true, "time": Date()], merge: true)
                    }
                }
        }
        // save when one person like first
        database.collection("users").document(uid).collection("available-users").document(id).setData(["hasDisplay": true], merge: true)
    }
    
    func saveDislikeUser(withId id: String) {
        guard let uid = getCurrentUserId() else { return }
        database.collection("users").document(uid).collection("available-users").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func saveMessage(message: Message) {
        guard let data = message.getMessageDictionary() else { return }
        var ref: DocumentReference? = nil
        ref = database.collection("messages").addDocument(data: data, completion: { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                var messageRef = message
                messageRef.messageId = ref!.documentID
                self.saveMessageReference(message: messageRef)
            }
        })
    }
    
    func uploadUserImages(images: [UIImage], _ completion: @escaping()->()){
        if let uid = auth.currentUser?.uid {
            var index = 0
            for image in images {
                uploadImageOntoStorage(image: image, uid: uid, index: index, {
                    if index == images.count {
                        completion()
                    }
                })
                index += 1
            }
        }
    }
    
    func uploadImageMessage(message: Message) {
        guard let image = message.image else {
            return
        }
        var updateMessage = message
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("messages-images").child("\(imageName).jpg")
        if let uploadData = image.jpegData(compressionQuality: 1.0) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url?.absoluteString else {
                        print("FirebaseService: error in downloadURL")
                        return
                    }
                    updateMessage.imageUrl = downloadURL
                    updateMessage.imageWidth = image.size.width
                    updateMessage.imageHeight = image.size.height
                    self.saveMessage(message: updateMessage)
                }
            }
        }
    }
    
    func uploadVideoMessage(url: URL, message: Message) {
        var updateMessage = message
        let videoName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("messages-videos").child("\(videoName).mov")
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
                        updateMessage.videoUrl = downloadURL
                        updateMessage.image = thumbnailImage
                        self.uploadImageMessage(message: updateMessage)
                    }
                }
            }
            uploadTask.observe(.success) { (snapshot) in
                print("Success")
            }
        }
    }
    
    func updateListOfUsers() {
        guard let uid = getCurrentUserId() else { return }
        database.collection("users").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if (uid != document.documentID) {
                        self.database.collection("users").document(uid).collection("available-users").document(document.documentID).setData(["hasDisplay": false, "id": document.documentID], merge: true)
                        self.database.collection("users").document(document.documentID).collection("available-users").document(uid).setData(["hasDisplay": false, "id": uid], merge: true)
                    }
                }
            }
        }
    }
    
    // MARK: Load data
    func loadAllUsers(_ completion: @escaping([UserModel]) -> ()) {
        guard let uid = auth.currentUser?.uid else { return }
        database.collection("users").document(uid).collection("available-users").whereField("hasDisplay", isEqualTo: false).getDocuments { (querySnapshot, err) in
            if err != nil {
                print("Error getting documents")
                return
            }
            var users: [UserModel] = []
            var index = 0
            for document in querySnapshot!.documents {
                if uid == document.documentID {
                    return
                }
                self.loadUserProfile(withId: document.documentID) { user in
                    users.append(user)
                    index += 1
                    if (index == querySnapshot!.documents.count) {
                        completion(users)
                    }
                }
            }
        }
    }
    
    func loadUserProfile(withId id: String,_ completion: @escaping(UserModel)->()) {
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
            var user = UserModel(info: data)
            self.loadUserImages(withId: id) { images in
                user.images = images
                completion(user)
            }
        }
    }
    
    func loadUserImages(withId id: String,_ completion: @escaping([UIImage])->()) {
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
            self.downloadImages(data: data) { images in
                completion(images)
            }
        }
    }
    
    func loadListMessages(_ completion: @escaping([ListMessageModel])->()) {
        guard let uid = auth.currentUser?.uid else { return }
        database.collection("user-messages").document(uid).collection("match-users").order(by: "time").getDocuments() { (querySnapshot, err) in
            if err != nil {
                print("Error getting documents: \(String(describing: err))")
                return
            }
            var models: [ListMessageModel] = []
            var index = 0
            for document in querySnapshot!.documents {
                let id = document.documentID
                self.getListMessage(withId: id) { listMessageModel in
                    // update data
                    if models.count == querySnapshot!.documents.count {
                        guard let modelIndex = self.getListMessageModelAtIndex(listMessageModel: listMessageModel, models: models) else { return }
                        models.remove(at: modelIndex)
                        models.insert(listMessageModel, at: modelIndex)
                        completion(models)
                    // add new list message
                    } else {
                        models.append(listMessageModel)
                    }
                    
                    index += 1
                    if index == querySnapshot!.documents.count {
                        completion(models)
                    }
                }
            }
        }
    }
    
    func loadMessages(withId id: String, _ completion: @escaping ([Message]) -> ()) {
        var totalMessages = 0
        var currentMessageIndex = 0
        var messages: [Message] = []
        
        getMessages(toId: id, { data in
            if data.isEmpty {
                completion([])
                return
            }
            guard let messageId = data["messageId"] as? String else {
                completion([])
                return
            }
            self.getMessageDetails(with: messageId, { messageData in
                guard let time = messageData["time"] as? Timestamp else { return }
                let convertedTime = self.convertToDate(timestamp: time)
                var values = messageData
                values.updateValue(convertedTime, forKey: "time")
                var message: Message!
                if let imageUrl = values["imageUrl"] as? String {
                    self.downloadImageFromStorage(url: imageUrl, { image in
                        message = Message(dictionary: values, image: image)
                        messages.append(message)
                        currentMessageIndex += 1
                        if (currentMessageIndex == totalMessages) {
                            completion(messages)
                        }
                    })
                } else {
                    message = Message(dictionary: values)
                    messages.append(message)
                    currentMessageIndex += 1
                    if (currentMessageIndex == totalMessages) {
                        completion(messages)
                    }
                }
            })
            totalMessages += 1
        })
    }
}

// MARK: - Authentication
extension FirebaseService : Authentication {
    func getCurrentUserId() -> String? {
        return auth.currentUser?.uid
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func logUserIn(withEmail email: String, password: String,  completion: @escaping(String?)->()) {
        auth.signIn(withEmail: email, password: password, completion: {(authResult, error) in
            if error != nil {
                completion(error?.localizedDescription)
                return
            }
            print("Successfully log user into firebase")
            completion(nil)
        })
    }
    
    func logUserIn(withCredential accessToken: String, completion: @escaping (String?) -> ()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        auth.signIn(with: credential) { (authResult, error) in
            if error != nil {
                completion(error?.localizedDescription)
                return
            }
            print("Successfully log user into firebase")
            completion(nil)
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

