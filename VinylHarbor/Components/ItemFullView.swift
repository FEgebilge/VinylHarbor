//
//  ItemFullView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 30.12.2023.
//

import SwiftUI

struct ItemFullView: View {
    let vinyl: Vinyl // Vinyl object to display details
    @Environment(\.presentationMode) var presentationMode
    @State private var showingTransactionView = false
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("Title: \(vinyl.Title)")
                Text("Artist: \(vinyl.Artist)")
                Text("Release Date: \(formattedDate(from: vinyl.ReleaseDate))")
                Text("Genre: \(vinyl.Genre)")
                Text("Condition: \(vinyl.Condition)")
                Text("Cover Condition: \(vinyl.CoverCondition)")
                Text("Price: $\(String(format: "%.2f", vinyl.Price))")
                Text("Description: \(vinyl.Description)")
            }
            .font(.callout)
            .padding()
        }
        Button(action: {
            showingTransactionView.toggle()
        }) {
            Text("Buy")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
        }
        .sheet(isPresented: $showingTransactionView) {
            TransactionView()
        }
        Spacer()
        
        .navigationTitle("Vinyl Details")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
        )
    }
}
// Helper function to format date
private func formattedDate(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}


// Sample Vinyl struct
struct Vinyl: Identifiable {
    let id: Int
    let Title: String
    let Artist: String
    let ReleaseDate: Date
    let Genre: String
    let Condition: String
    let CoverCondition: String
    let Price: Double
    let Description: String
    let SellerID: Int
    let CustomerID: Int
}

// Sample data
let sampleVinyl = Vinyl(
    id: 1,
    Title: "Sample Vinyl",
    Artist: "Sample Artist",
    ReleaseDate: Date(),
    Genre: "Sample Genre",
    Condition: "Mint",
    CoverCondition: "Desc",
    Price: 25.0,
    Description: "NM",
    SellerID: 101,
    CustomerID: 0
)



struct VinylDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemFullView(vinyl: sampleVinyl)
    }
}

