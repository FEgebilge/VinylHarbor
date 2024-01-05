//
//  ContentView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
                .navigationBarHidden(true)
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
