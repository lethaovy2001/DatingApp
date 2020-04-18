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
    
    func getUserID() -> String? {
        return Auth.auth().currentUser?.uid
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
    
    func setDataToDatabase(user: UserModel) {
        if let uid = Auth.auth().currentUser?.uid {
            do {
                try database.collection("users").document(uid).setData(from: user, merge: true)
                print("Document successfully written!")
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
        } else {
            print("*** FirebaseService: User ID is nil")
        }
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
}
