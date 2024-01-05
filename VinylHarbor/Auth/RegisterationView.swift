//
//  RegisterationView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 5.01.2024.
//

import SwiftUI

struct RegisterationView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @State private var username=""
    @State private var name=""
    @State private var email=""
    @State private var phone=""
    @State private var billingAddress=""
    @State private var shippingAddress=""
    @State private var location=""
    @State private var descrtiption=""
    @State private var password=""
    
    var body: some View {
        VStack{
            
            VStack(alignment:.leading){
                Spacer()
                HStack{Spacer()}
                Text("Welcome to the harbor.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                
                Text("Create your account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
            }
            .padding(.leading)
            .frame(height:260)
            .background(Color.purple)
            .foregroundColor(.black)
            
            VStack(spacing:31){
                SignTextFields(imageName: "person", placeHolderText: "Username", text: $username)
                SignTextFields(imageName: "person", placeHolderText: "Name", text: $name)
                SignTextFields(imageName: "envelope", placeHolderText: "Email", text: $email)
                SignTextFields(imageName: "phone", placeHolderText: "Phone", text: $phone)
                SignTextFields(imageName: "house", placeHolderText: "Billing Address", text: $billingAddress)
                SignTextFields(imageName: "house", placeHolderText: "Shipping Adress", text: $shippingAddress)
                SignTextFields(imageName: "mappin", placeHolderText: "Location", text: $location)
                SignTextFields(imageName: "highlighter", placeHolderText: "Description", text: $descrtiption)
               
                
                SignTextFields(imageName: "lock", placeHolderText: "Password",isSecureField: true, text: $password)
                
            }
            .padding(.horizontal,30)
            .padding(.top,40)
            
            
            Button {
                registerUser()
            } label: {
                Text("Set Sail")
                    .font(.headline)
                    .frame(width: 150, height: 40)
                    .foregroundColor(.purple)
                    .background(Color.black)
                    .clipShape(Capsule())
                    .padding(.top,10)
            }
            .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 0)
            
            
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.purple)
                        .font(.footnote)
                    
                    Text("Sign in")
                        .foregroundColor(.purple)
                        .fontWeight(.semibold)
                }.padding(.bottom,32)
            }

        }
        .ignoresSafeArea()
    }
    func registerUser(){
        guard   !username.isEmpty,
                !name.isEmpty,
                !email.isEmpty,
                !phone.isEmpty,
                !billingAddress.isEmpty,
                !shippingAddress.isEmpty,
                !location.isEmpty,
                !password.isEmpty
                else {
              // Show an alert or perform some action to notify the user about empty fields
              return
          }
        DatabaseManager.createUser(username: username, name: name, email: email, phone: phone, billingAddress: billingAddress, shippingAddress: shippingAddress, location: location, bookmarkedVinyls: [], sellerRating: 0 , customerRating: 0, description: descrtiption, password: password)
        print("User added to database")
        dismiss()
}


}
#Preview {
    RegisterationView()
}
