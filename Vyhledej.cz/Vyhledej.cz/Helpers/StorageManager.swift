//
//  StorageManager.swift
//  Vyhledej.cz
//
//  Created by Rodion Trach on 13.04.2023.
//

import Foundation
import UIKit

private extension String {
    static let usernameKey = "usernameKey"
}

class StorageManeger {
    static let shared = StorageManeger()
    private let userDefaults = UserDefaults.standard
    private var loggedInUser = ""
    
    private init() {}
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func logIn(username: String, password: String) -> Bool {
        if let savedUsers = self.userDefaults.value([User].self, forKey: .usernameKey) {
            if savedUsers.first(where: { $0.username == username && $0.password == password }) != nil {
                loggedInUser = username
                return true
            } else {
                self.showAlert(title: "Error", message: "Incorrect username or password")
            }
        } else {
            self.showAlert(title: "Error", message: "User not found")
        }
        return false
    }
    
    func createNewAccount(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            self.showAlert(title: "Error", message: "Username or password can not be empty")
            return
        }
        var existingUsers: [User] = self.userDefaults.value([User].self, forKey: .usernameKey) ?? []
        if existingUsers.contains(where: { $0.username == username}) {
            self.showAlert(title: "Error", message: "User with this username already exists")
            return
        }
        let newUser = User(username: username, password: password)
        existingUsers.append(newUser)
        self.userDefaults.set(encodable: existingUsers, forKey: .usernameKey)
        self.showAlert(title: "Success", message: "User has been registered")
    }
    
}
