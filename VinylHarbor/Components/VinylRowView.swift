//
//  UserRowView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct VinylRowView: View {
    var body: some View {
        HStack(alignment:.top,spacing: 10){
            Circle()
                .frame(width: 48, height: 48)
            
            VStack(alignment:.leading){
                Text("Title of the Record")
                    .font(.subheadline).bold()
                    
                Text("Artist of the Record")
                    .font(.subheadline).bold()
                Text("Condition: ")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Text("Cover Condition: ")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Text("Price:")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
            }
            Spacer()
        }
        .padding(.leading,10)
        
        
    }
}

#Preview {
    VinylRowView()
}
