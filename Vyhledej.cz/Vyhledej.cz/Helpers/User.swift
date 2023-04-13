//
//  User.swift
//  Vyhledej.cz
//
//  Created by Rodion Trach on 13.04.2023.
//

import Foundation

final class User: Codable {
    
    static let shared = User(username: "", password: "")
    let username: String?
    let password: String?
    
    init(username: String?, password: String?) {
        self.username = username
        self.password = password
    }
}
