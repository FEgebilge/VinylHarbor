//
//  ItemFullView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 30.12.2023.
//

import SwiftUI

struct ItemFullView: View {
    var vinyl: Vinyl // Vinyl object to display details
    @State private var showAlert = false
    @State private var showTransactionSuccessfull = false
    @State private var sellerUsername: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.black,Color.black, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
    let currentUser = UserAuthManager.shared.currentUser

    func CompleteTransaction(){
        do{
        try DatabaseManager.sellVinyl(SellID: vinyl.id, CurrentUserID: currentUser!.userID)
        }catch{
            print(error)
            showAlert=true
        }
        DatabaseManager.insertTransaction(vinylID: vinyl.id, customerID: currentUser!.userID, sellerID: vinyl.SellerID, transactionDate: Date(), transactionAmount: vinyl.Price)
        
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Seller: \(sellerUsername)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray)
                
                Text(vinyl.Title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

                Text("\(vinyl.Artist)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                Text("Release Date: \(formattedDate(from: vinyl.ReleaseDate))")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray2))
                Text("Genre: \(vinyl.Genre)")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray2))
                Text("Condition: \(vinyl.Condition)")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray2))
                Text("Cover Condition: \(vinyl.CoverCondition)")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray2))
                
                Text("Description:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.systemGray2))
                Text(vinyl.Description)
                    .font(.body)
                    .foregroundStyle(Color(.systemGray2))

                
                Text("Price: $\(String(format: "%.2f", vinyl.Price))")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)

                Spacer()

                if currentUser?.userID != vinyl.SellerID{
                                  Button {
                                      CompleteTransaction()
                                      showTransactionSuccessfull=true
                                      dismiss()
                                  } label:{
                                      Text("Drop Anchor")
                                          .fontWeight(.semibold)
                                          .font(.title3)
                                          .padding(.vertical, 15)
                                          .frame(maxWidth: .infinity)
                                          .foregroundStyle(Color.purple.opacity(0.8))
                                          .background(Color.black)
                                          .cornerRadius(10)
                                  }
                                  .padding(.horizontal,30)
                                  .shadow(color: .purple.opacity(0.8), radius: 15)
                              }
                Spacer()
                  
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error!"), message: Text("Error While Selling"), dismissButton: .default(Text("OK")){
                    showAlert=false
                })
            })
            .alert(isPresented: $showTransactionSuccessfull, content: {
                Alert(title: Text("Transaction Successfull!"), message: Text("Thanks for purchase"), dismissButton: .default(Text("OK")){
                    showTransactionSuccessfull=false
                })
            })
           
        }
        .frame(maxWidth: .infinity)
        .onAppear{
            sellerUsername = DatabaseManager.fetchSellerUsername(for: vinyl.SellerID) ?? "Unkown"
        }
        .background(gradient)
        .navigationTitle("Vinyl Details")
        .navigationBarTitleDisplayMode(.inline)
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

// ... (rest of your code remains the same)


// Vinyl struct
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
    var OnSell:Int
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
    CustomerID: 0,
    OnSell:1
)


/*
struct VinylDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemFullView(vinyl: sampleVinyl)
    }
 
}

*/
