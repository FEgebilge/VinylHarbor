//
//  TextArea.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var text:String
    let placeholdher:String
    
    
    init(_ placeholder:String , text:Binding<String>){
        self.placeholdher=placeholder
        self._text=text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            if text.isEmpty{
                Text(placeholdher)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal,8)
                    .padding(.vertical,12)
            }
            
            TextEditor(text: $text)
                
                .padding(4)
        }
        .font(.body)
    }
}
