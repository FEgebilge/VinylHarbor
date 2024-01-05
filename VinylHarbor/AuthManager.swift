//
//  AuthManager.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 5.01.2024.
//

import Foundation

class UserAuthManager: ObservableObject {
    static let shared = UserAuthManager()
    
    @Published var currentUser: DatabaseManager.User? {
        didSet {
            // Save user's signed-in state to UserDefaults when currentUser changes
            if let encoded = try? JSONEncoder().encode(currentUser) {
                UserDefaults.standard.set(encoded, forKey: "currentUser")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentUser")
            }
        }
    }

    init() {
        // Retrieve user's signed-in state from UserDefaults when UserAuthManager is initialized
           if let savedUser = UserDefaults.standard.data(forKey: "currentUser") {
               do {
                   let loadedUser = try JSONDecoder().decode(DatabaseManager.User.self, from: savedUser)
                   currentUser = loadedUser
               } catch {
                   print("Error decoding user data:", error)
                   currentUser = nil
               }
           } else {
               currentUser = nil
           }
    }
    
    func signIn(username: String, password: String) {
        guard let user = DatabaseManager.authenticateUser(username: username, password: password) else {
            print("Authentication failed")
            return
        }
        currentUser = user
    }
    
    func signOut() {
        currentUser = nil
    }
}
