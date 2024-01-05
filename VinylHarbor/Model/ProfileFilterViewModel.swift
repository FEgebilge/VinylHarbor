//
//  ProfileFilterViewModel.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import Foundation

import Foundation

enum ProfileFilterViewModel: Int,CaseIterable{
    
    case sells
    case buys
    
    var title : String{
        switch self{
        case .sells:return "Sold"
        case.buys:return "Bought"
        }
    }
}
