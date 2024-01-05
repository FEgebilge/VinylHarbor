//
//  ContentView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authManager: UserAuthManager
    
    
    var body: some View {
            if authManager.currentUser == nil{
                LoginView()
                    .environmentObject(authManager)
            }else{
                NavigationView {
                    MainTabView()
                        .environmentObject(authManager)
                       
                }
            }
        }
        
    }

/*
 Group{
    if ViewModel.userSession == nil{
        LoginView()
    }else{
        NavigationView {
            MainTabView()
                .navigationBarHidden(true)
        }
    }
}
*/
#Preview {
    ContentView()
}
