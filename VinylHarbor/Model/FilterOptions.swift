//
//  FilterOptions.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 4.01.2024.
//

import Foundation
import SwiftUI

class FilterOptions: ObservableObject {
    @Published var selectedSortOption = 0
    @Published var selectedVinylCondition = 0
    @Published var selectedCoverCondition = 0
}

