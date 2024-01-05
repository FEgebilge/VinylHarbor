//
//  ProfileFilterViewModel.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import Foundation

import Foundation

enum ProfileFilterViewModel: Int,CaseIterable{
    
    case onSell
    case buys
    
    var title : String{
        switch self{
        case .onSell:return "On Sell"
        case.buys:return "Bought"
        }
    }
}
