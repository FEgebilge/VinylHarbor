//
//  NewItemView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct NewItemView: View {
    
    @EnvironmentObject var userAuthManager: UserAuthManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var title: String = ""
    @State private var artist: String = ""
    @State private var releaseDate: Date = Date()
    @State private var genre: String = ""
    @State private var condition: String = ""
    @State private var coverCondition: String = ""
    @State private var price: Double = 0.0
    @State private var description: String = ""
    @State private var sellerID: Int = 0
    @State private var customerID: Int = 0
    @Binding var isAddingNewItem: Bool
    @State private var isItemAdding = false

    
    
    let conditionOptions = ["M", "NM", "VG+", "VG","G+","G","F", "P"]
    let coverConditionOptions = ["M", "NM", "VG+", "VG","G+","G","F", "P"]
    
    var onItemAdded: (() -> Void)?
    
    @Environment (\.dismiss) var dismiss
    var body: some View {
        
        /*NavigationLink(destination: SearchView(), isActive: $isAddingNewItem) {
                EmptyView()
            }
            .hidden()
        */
        let gradient = LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.purple]), // Set your desired colors here
                    startPoint: .topLeading, // Start the gradient from the top leading corner
                    endPoint: .bottomTrailing // End the gradient at the bottom trailing corner
                )

       
        VStack(alignment:.leading){
            HStack{
                Spacer()
             
                       
               Button {
                    print("Add Clicked")
                    saveDataToDatabase()   
                  
                    
                } label: {
                    Text("Add")
                        .fontWeight(.bold)
                        .bold()
                        .padding(.horizontal,30)
                        .padding(.vertical,8)
                    
                }
              
                .sheet(isPresented: $isItemAdding, content: {
                    NavigationStack{
                        
                    }
                })
                
    
            }
            .padding()
         
                            Form {
                                Section(header: Text("Record Information")) {
                                    TextField("Title", text: $title)
                                    TextField("Artist", text: $artist)
                                    DatePicker("Release Date", selection: $releaseDate, displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                        .accentColor(.purple)
                                    TextField("Genre", text: $genre)
                                    
                                    Picker("Condition", selection: $condition) {
                                        ForEach(conditionOptions, id: \.self) { option in
                                            Text(option)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .accentColor(.purple)
                                    
                                    Picker("Cover Condition", selection: $coverCondition) {
                                        ForEach(coverConditionOptions, id: \.self) { option in
                                            Text(option)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .accentColor(.purple)
                                    
                                    TextField("Price", text: Binding(get: {
                                        String(format: "%.2f", price) // Convert the Double to a formatted String
                                    }, set: { newValue in
                                        if let value = Double(newValue) {
                                            price = value // Update 'price' when the TextField value changes
                                        }
                                    }))
                                    
                                    
                                    TextField("Description", text: $description)
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .foregroundStyle(Color.purple)
                            .navigationBarTitleDisplayMode(.large)
                            Spacer()
                          
                          
               
        }
        
        .background(gradient)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Warning"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear(){
            sellerID = userAuthManager.currentUser!.userID
            if condition.isEmpty{
                condition=conditionOptions[0]
            }
            if coverCondition.isEmpty{
                coverCondition=coverConditionOptions[0]
            }
        }

        .onDisappear(){
            SearchView().refreshVinyl()
        }
        
    }

 
    func saveDataToDatabase() {
        guard !title.isEmpty,
                !artist.isEmpty,
                !genre.isEmpty,
                !condition.isEmpty,
                !coverCondition.isEmpty,
                !description.isEmpty,
                price > 0.0
                else {
            
                alertMessage = "Please fill in all the fields."
                  showAlert = true
                  return
          }

        DatabaseManager.insertVinyl(title: title, artist: artist, releaseDate: releaseDate, genre: genre, condition: condition, coverCondition: coverCondition, price: price, description: description, sellerID: sellerID)
        
        isAddingNewItem = false
        onItemAdded?()
    }
    
    
}




#Preview {
    NewItemView(isAddingNewItem: .constant(true))
}
