//
//  SearchView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//
import SwiftUI


struct SearchView: View {
    @StateObject var filterOptions = FilterOptions()
    @State private var showNewItemPanel=false
    @State private var searchText = ""
    @State private var isFilterViewPresented = false // Added state for presenting the filter view
    
   
    @State private var vinyls: [Vinyl] = []

    func refreshVinyl(){
        do {
            vinyls = try DatabaseManager.getVinyls(searchText: searchText)
            vinyls.reverse()
            
        } catch {
            print("Error fetching vinyls:", error)
        }
    }
    
    func updateFilteredVinyls(_ filteredVinyls: [Vinyl]) {
           self.vinyls = filteredVinyls // Update the @State variable with filtered data
       }

    
    let sampleVinyls: [Vinyl] = [
        Vinyl(id: 10, Title: "SampleTit", Artist: "SampleArt", ReleaseDate: Date(), Genre: "SampleGen", Condition: "A", CoverCondition: "A", Price: 3, Description: "Iyi", SellerID: 5, CustomerID: 5, OnSell: 1)
       
          // Add more sample vinyl records if needed...
      ]
      
    
    var body: some View {
        
        
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color.purple,Color.black,Color.black, Color.black]), // Set your desired colors here
                    startPoint: .topLeading, // Start the gradient from the top leading corner
                    endPoint: .bottomTrailing // End the gradient at the bottom trailing corner
        )
           
        ZStack (alignment:.bottomTrailing){
            NavigationView{
                VStack{
                    HStack {
                        SearchBar(searchText: $searchText)
                            .onChange(of: searchText) { searchText, _ in
                                refreshVinyl()
                            }
                        
                        Button(action: {
                            isFilterViewPresented.toggle() // Toggle the state to show/hide filter view
                            refreshVinyl()
                        }) {
                            Image(systemName: "slider.horizontal.3") // Filter button
                                .foregroundColor(.purple)
                                .padding(.horizontal)
                        }
                        
                    }
                    
                    ScrollView{
                        LazyVStack{
                            ForEach(vinyls , id: \.id){ vinyl in
                                NavigationLink{
                                    ItemFullView(vinyl: vinyl)
                                }label: {
                                    ItemRowView(vinyl:vinyl)
                                }
                            }
                        }
                    }
                }
                .background(gradient)
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isFilterViewPresented) {
                    FilterView(isFilterViewPresented: $isFilterViewPresented, vinyls: $vinyls, searchViewCallback: updateFilteredVinyls(_:))
                }
                
              
            }
            
           
            /*
            Button {
                showNewItemPanel.toggle()
            } label: {
                
           Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(9)
                    
            }
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewItemPanel) {
                NewItemView()
            }
            */
        }
        .onTapGesture {
            endEditing()
        }
        .onAppear {
                refreshVinyl()
        }
    }
    
}
#Preview{
  SearchView()
}

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .background(Color(.systemFill))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.vertical)
                .shadow(color: .black.opacity(0.7), radius: 8, x: 0, y: 0)
        }
    }
    
    
}


func endEditing() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }




