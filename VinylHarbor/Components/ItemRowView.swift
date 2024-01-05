//
//  ItemRowView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct ItemRowView: View {
    let vinyl: Vinyl

    var body: some View {
        VStack(alignment:.leading){
            
            HStack(alignment: .top, spacing: 12){
                
                Circle()
                    .frame(width:56,height: 56)
                
                VStack(alignment:.leading,spacing: 3){
                    
                   
                    HStack{
                        Text(vinyl.Title)
                            .font(.headline).bold()
                            .foregroundStyle(Color(.systemGray2))
                        
    
                    }
                    Text(vinyl.Artist)
                        .font(.headline).bold()
                        .foregroundStyle(Color(.systemGray2))
                        
                    
                    Section{
                        Text("Release Date:\(formattedDate(from: vinyl.ReleaseDate))")
                        Text("Condition:\(vinyl.Condition) ")
                        Text("Cover Condition:\(vinyl.CoverCondition)")
                        Text("Price: $\(String(format: "%.2f", vinyl.Price))")

                    }
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.gray)
                }
                
            }
            
            HStack{
                Spacer()
            Button {
                //button
            } label: {
                (Image(systemName: "bookmark"))
                    .font(.subheadline)
                }
            }
            .foregroundColor(.secondary)
            .padding()
            
            Divider()
            

        }
        .padding()
        
        
    }
        
}

private func formattedDate(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

/*#Preview {
    ItemRowView(vinyl: Vinyl(id: 1, Title: "Sample Title", Artist: "Sample Artist", ReleaseDate: "2024-01-05", Genre: "Pop", Condition: "Mint", CoverCondition: "NM", Price: 29.99, SellerID: 101))
}
*/
