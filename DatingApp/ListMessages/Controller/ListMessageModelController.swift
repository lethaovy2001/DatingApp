//
//  ListMessageModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageModelController {
    // MARK: Properties
    private var users = [UserModel]()
    private var messages = [Message]()
    private var listMessages = [ListMessageModel]()
    private let database: Database
    
    // MARK: - Initializer
    init(database: Database) {
        self.database = database
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Getters
    func getListMessages() -> [ListMessageModel] {
        return listMessages
    }
    
    // MARK: - Load data
    func loadData(_ completion : @escaping()->()) {
        database.loadListMessages() { listMessageModels in
            self.listMessages = listMessageModels
            completion()
        }
    }
}
