//
//  ProfileView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI


struct ProfileView: View {
    
    
    @State private var selectedFilter:ProfileFilterViewModel = .sells
    @Environment (\.dismiss) var mode
    @Namespace var animation
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    
    
    var body: some View {
            VStack(alignment:.leading){
                headerView
                actionButtons
                userInfoDetails
                tweetFilterBar
                tweetsInProfileView
        
                Spacer()
            }
        }
    }


#Preview {
    ProfileView()
}

extension ProfileView{

    var headerView: some View{
        if let currentUser = userAuthManager.currentUser  {
            return AnyView(
            ZStack(alignment:.bottomLeading){
                
                Color(.purple)
                    .ignoresSafeArea()
                
                VStack {
                        Text(currentUser.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .bold()
                        .padding()
                }
            }
            .frame(height:100))
            }
            else{
                return AnyView(
                Text("No user logged in")
                )
            }
        }
    
    
    var actionButtons:some View{
        
        HStack(spacing:12){
            Spacer()
            Button {
                print("sign out clicked")
                UserAuthManager.shared.signOut()
            } label: {
                Text("Sign Out")
                    .font(.subheadline).bold()
                    .foregroundColor(.purple)
                    .frame(width:120,height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth:0.75))
                
            }
            
            
        }.padding(.trailing)
        
        
    }
    var userInfoDetails: some View{
        if let currentUser = userAuthManager.currentUser  {
            return AnyView(
            VStack(alignment: .leading, spacing: 4){
                Text(currentUser.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(currentUser.description)
                    .font(.subheadline)
                    .padding(.vertical,7)
                .font(.caption)
                .foregroundColor(.secondary)
                Spacer()
                HStack {
                    HStack(spacing:20){
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text(currentUser.location)
                                .font(.callout)
                        }
                    
                    }
                    UserStatsView()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    
                }
               
            }
            .padding(.horizontal))
        }
        else{
            return AnyView(
            Text("No user logged in")
            )
        }
    }
    
    
    
    var tweetFilterBar :some View {
        
        HStack{
            ForEach(ProfileFilterViewModel.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold: .regular)
                        .foregroundColor(selectedFilter == item ? .black :.secondary)
                    if selectedFilter==item{
                        Capsule()
                            .foregroundColor(.purple)
                            .frame(height:4)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height:4)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter=item
                    }
                }
            }
            
        }
        .overlay(Divider().offset(x:0,y:16))
        
        
    }
    
    
    var tweetsInProfileView : some View{
        ScrollView{
            LazyVStack{
                ForEach(0...6, id: \.self){ _ in
                    VinylRowView()
                }
            }
        }
    }
    
}
