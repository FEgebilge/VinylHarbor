//
//  UserStatsView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct UserStatsView: View {
    
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    
    var body: some View{
        if let currentUser = userAuthManager.currentUser{
            HStack(spacing:20){
                HStack(spacing:4){
                    Text("Seller Rating").font(.caption)
                        .foregroundColor(.secondary)
                    Text(String(currentUser.sellerRating)).bold().font(.subheadline)
                }
                
                HStack(spacing:4){
                    Text("Customer Rating").font(.caption)
                        .foregroundColor(.secondary)
                    Text(String(currentUser.customerRating)).bold().font(.subheadline)
                }
            }
            .padding(.vertical,10)
        }
        else{
            Text("No user signed in")
        }
    }
}

#Preview {
    UserStatsView()
}
