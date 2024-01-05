//
//  SignTextFields.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 5.01.2024.
//

import SwiftUI

import SwiftUI

struct SignTextFields: View {
    let imageName:String
    let placeHolderText:String
    var isSecureField:Bool?=false
    @Binding var text:String
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField ?? false{
                    SecureField(placeHolderText, text: $text)
                }else{
                    TextField(placeHolderText, text: $text)
                }
            }
            .frame(height:10)
            Divider()
        }
    }
}


#Preview {
    SignTextFields(imageName: "envelope", placeHolderText: "Email", text: .constant(""))
}
