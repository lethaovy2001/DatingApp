//
//  ViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
//import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    let fbLoginButton: RoundedButton = {
        let button = RoundedButton(title: "LOG IN WITH FACEBOOK", color: Constants.fbColor)
       button.addTarget(self, action: #selector(loginWithFacebook), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    // MARK: Setup
    private func addSubViews() {
        view.addSubview(fbLoginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fbLoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            fbLoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36),
            fbLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //TODO: Handle error
    @objc func loginWithFacebook() {
//        let loginManager = LoginManager()
//
//        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
//            if error != nil {
//                print("***** Error: \(error!)")
//            } else if result?.isCancelled == true {
//                
//                print("***** Cancel")
//            } else {
//                print("***** Log in with Facebook")
//                let vc = MainViewController()
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SwiftLeeViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!.view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct SwiftLeeViewController_Preview: PreviewProvider {
    static var previews: some View {
        SwiftLeeViewRepresentable()
    }
}
#endif
