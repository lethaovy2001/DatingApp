//
//  UserModelController.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewModel {
    // MARK: - Properties
    private var model: UserModel
    private let type: UserType
    
    enum UserType {
        case currentUser
        case otherUser
    }
    
    // MARK: - Initializer
    init(model: UserModel) {
        self.model = model
        self.type = .currentUser
    }
    
    init(model: UserModel, type: UserType) {
        self.model = model
        self.type = type
    }
}

extension UserDetailsViewModel {
    var name: String {
        return model.name ?? ""
    }
    
    var ageText: String {
        guard let date = model.birthday else { return "" }
        let converter = AgeConverter()
        let age = converter.convertToAge(from: date)
        return "\(age)"
    }
    
    var work: String {
        return model.work ?? ""
    }
    
    var images: [UIImage] {
        return model.images ?? []
    }
    
    var bio: String {
        return model.bio ?? ""
    }
    
    var id: String? {
        return model.id ?? nil
    }
    
    var userType: UserType {
        return self.type
    }
}

extension UserDetailsViewModel {
    func configure(_ view: UserDetailsView) {
        switch userType {
        case .currentUser:
            view.nameContainerHeight?.constant = 100
            break
        case .otherUser:
            view.customNavigationView.hideEditButton()
            view.nameContainerView.displayLocation()
            view.nameContainerHeight?.constant = 120
        }
        view.bioContainerView.bioTextView.setText(text: bio)
        view.nameContainerView.nameLabel.setText(text: name)
        view.nameContainerView.ageLabel.setText(text: ", \(ageText)")
        view.nameContainerView.workLabel.setText(text: work)
        view.cardImages = images
        if let image = images.first {
            view.userImageView.setImage(image: image)
        }
    }
}
