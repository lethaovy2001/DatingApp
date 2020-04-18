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
    
    init() {
        database = Firestore.firestore()
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
    
    func updateDatabase(user: UserModel) {
        if let uid = getUserID() {
            do {
                try database.collection("users").document(uid).setData(from: user, merge: true)
                print("Document successfully written!")
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
        }
    }
    
    private func getUserID() -> String? {
        if let userID = Auth.auth().currentUser?.uid {
            return userID
        }
        return nil
    }
    
}
