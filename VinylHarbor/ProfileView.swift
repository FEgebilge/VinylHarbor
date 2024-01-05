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
            ZStack(alignment:.bottomLeading){
                
                Color(.purple)
                    .ignoresSafeArea()
                
                VStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .offset(x: 20, y: 25)
                }
            }
            .frame(height:100)
        }
    
    
    var actionButtons:some View{
        
        HStack(spacing:12){
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray,lineWidth: 0.75))
            
            Button {
                //action
            } label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                    .frame(width:120,height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth:0.75))
                
            }
            
            
        }.padding(.trailing)
        
        
    }
    
    var userInfoDetails:some View{
        VStack(alignment: .leading, spacing: 4){
            HStack {
                Text("MadmanOfCity")
                    .font(.title3).bold()
                
            }
            
            Text("@madman")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Madman of the city was here!")
                .font(.subheadline)
                .padding(.vertical,7)
            
    
            .font(.caption)
            .foregroundColor(.secondary)
            HStack {
                HStack(spacing:20){
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                        Text("Gotham City")
                            .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                    }
                
                }
                Spacer()
                UserStatsView()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                
                
            }
           
        }
        .padding(.horizontal)
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
