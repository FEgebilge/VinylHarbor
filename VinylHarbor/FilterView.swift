//
//  FilterView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 30.12.2023.
//

import SwiftUI


struct FilterView: View {
    
    @StateObject var filterOptions = FilterOptions()
    @Binding var isFilterViewPresented: Bool
    @State private var selectedSortOption = 0
    @State private var selectedVinylCondition = 0
    @State private var selectedCoverCondition = 0
    @Binding var vinyls: [Vinyl]
    var searchViewCallback: ([Vinyl]) -> Void
    

        let sortOptions = ["Increasing Price", "Decreasing Price"]
        let VinylConditionOptions = ["All","M", "NM", "VG+", "VG","G+","G","F", "P"]
        let CoverConditionOptions = ["All","M", "NM", "VG+", "VG","G+","G","F", "P"]

        var body: some View {
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Sort by Price:")
                    .font(.headline)
                Picker("Sort Option", selection: $selectedSortOption) {
                    ForEach(0..<sortOptions.count, id: \.self) { index in
                        Text(sortOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Text("Vinyl Condition:")
                    .font(.headline)
                Picker("Condition Option", selection: $selectedVinylCondition) {
                    ForEach(0..<VinylConditionOptions.count, id: \.self) { index in
                        Text(VinylConditionOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                Text("Cover Condition:")
                    .font(.headline)
                Picker("Condition Option", selection: $selectedCoverCondition) {
                    ForEach(0..<VinylConditionOptions.count, id: \.self) { index in
                        Text(VinylConditionOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button("Apply Filters") {
                    // Apply filters
                    // Close the filter view
                    applyFilters()
                    isFilterViewPresented.toggle()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(15)
             
            }
            .padding()
        }
    func applyFilters() {
        var sortedVinyls = vinyls
        var filteredVinyls = vinyls
        // Implement filtering logic based on selectedSortOption and selectedConditionOption
        switch selectedSortOption {
        
        case 0:
          sortedVinyls.sort { $0.Price < $1.Price }
                // Sort by Increasing Price
            break
        case 1:
            sortedVinyls.sort { $0.Price > $1.Price }
            // Sort by Decreasing Price
            break
        default:
            break
        }
        filteredVinyls=Array(sortedVinyls)
        switch selectedVinylCondition {
        case 0:
            // All Conditions logic - No specific condition filter
            break
        case 1:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "M" }
            // Logic for "Mint" condition filter
            break
        case 2:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "NM" }
            // Logic for "NM" condition filter
            break
        case 3:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "VG+" }
            // Logic for "VG+" condition filter
            break
        case 4:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "VG" }
            // Logic for "VG" condition filter
            break
        case 5:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "G+" }
            // Logic for "G+" condition filter
            break
        case 6:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "G" }
            // Logic for "G" condition filter
            break
        case 7:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "F" }
            // Logic for "F" condition filter
            break
        case 8:
            filteredVinyls = sortedVinyls.filter { $0.Condition == "P" }
            // Logic for "P" condition filter
            break
        // Add cases for other condition options as needed
        default:
            break
        }
        switch selectedCoverCondition {
        case 0:
            // All Conditions logic - No specific condition filter
            break
        case 1:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "M" }
            // Logic for "Mint" condition filter
            break
        case 2:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "NM" }
            // Logic for "NM" condition filter
            break
        case 3:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "VG+" }
            // Logic for "VG+" condition filter
            break
        case 4:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "VG" }
            // Logic for "VG" condition filter
            break
        case 5:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "G+" }
            // Logic for "G+" condition filter
            break
        case 6:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "G" }
            // Logic for "G" condition filter
            break
        case 7:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "F" }
            // Logic for "F" condition filter
            break
        case 8:
            filteredVinyls = filteredVinyls.filter { $0.CoverCondition == "P" }
            // Logic for "P" condition filter
            break
        // Add cases for other condition options as needed
        default:
            break
        }
        
        
        // After applying filters, you might update your data source or perform actions accordingly
        searchViewCallback(filteredVinyls)
        
    }

}
