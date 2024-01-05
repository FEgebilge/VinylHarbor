//
//  LoginView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 5.01.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username=""
    @State private var password=""
    @State private var showAlert = false
    //@EnvironmentObject var ViewModel:AuthViewModel
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment:.leading){
                    HStack{Spacer()}
                    Text("Hello.")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                }
                .padding(.leading)
                .frame(height:260)
                .background(Color.purple)
                .foregroundColor(.black)
                
                VStack(spacing:40){
                    
                    SignTextFields(imageName: "person", placeHolderText: "Username", text: $username)
                    
                    SignTextFields(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                    
                    
                }
                .padding(.horizontal,30)
                .padding(.top,40)
                
                
                HStack{
                    Spacer()
                    NavigationLink {
                        Text("Forgot")
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.purple)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing)
                    }
                    
                }
                
                Button {
                    let signInSuccess = UserAuthManager.shared.signIn(username: username, password: password)
                                       if !signInSuccess {
                                           showAlert = true
                                       } else {
                                           print("Signed In")
                                       }
                    
                } label: {
                    Text("Set Sail")
                        .font(.headline)
                        .frame(width: 340, height: 50)
                        .foregroundColor(.purple)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 0)
                
                
                
                Spacer()
                
                NavigationLink(destination: RegisterationView().navigationBarHidden(true)) {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.purple)
                            .font(.footnote)
                        
                        Text("Sign Up")
                            .foregroundColor(.purple)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 32)
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .alert(isPresented: $showAlert) {
                           Alert(
                               title: Text("Error"),
                               message: Text("Invalid username or password"),
                               dismissButton: .default(Text("OK")) {
                                   // Optionally add code to handle the alert dismissal
                                   showAlert = false
                               }
                           )
            }
        }
    }
    
}
#Preview {
    LoginView()
}
