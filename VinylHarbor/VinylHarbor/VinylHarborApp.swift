//
//  VinylHarborApp.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

@main
struct VinylHarborApp: App {
    
    @StateObject var authManager = UserAuthManager.shared
    
    var body: some Scene {
        WindowGroup {
         ContentView()
                .environmentObject(authManager)
        }
    }
}
