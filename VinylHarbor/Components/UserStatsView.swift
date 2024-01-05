//
//  UserStatsView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing:20){
            HStack(spacing:4){
                Text("SR").font(.caption)
                    .foregroundColor(.secondary)
                Text("9.2").bold().font(.subheadline)
            }
            
            HStack(spacing:4){
                Text("CR").font(.caption)
                    .foregroundColor(.secondary)
                Text("9.8").bold().font(.subheadline)
            }
        }
        .padding(.vertical,10)
    }
}

#Preview {
    UserStatsView()
}
