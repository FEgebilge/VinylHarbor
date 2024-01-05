//
//  ProfileView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//

import SwiftUI


struct ProfileView: View {
    
    
    @State private var selectedFilter:ProfileFilterViewModel = .onSell
    @Environment (\.dismiss) var mode
    @Namespace var animation
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @State private var vinylsOnSell: [Vinyl] = []
    @State private var vinylsBought: [Vinyl] = []
    
    var body: some View {
            VStack(alignment:.leading){
                headerView
                actionButtons
                userInfoDetails
                vinylFilterBar
                vinylsInProfileView
        
                Spacer()
            }
            .onAppear{
                vinylsOnSell = DatabaseManager.getVinylsForSellerID(currentUserID: userAuthManager.currentUser!.userID)
                vinylsBought = DatabaseManager.getVinylsBought(currentUserID: userAuthManager.currentUser!.userID)
            }
        }
    }


#Preview {
    ProfileView()
}

extension ProfileView{
    
    func getDataForSelectedFilter() -> [Vinyl] {
           switch selectedFilter {
           case .onSell:
               return vinylsOnSell
           case .buys:
               return vinylsBought
           }
       }

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
                HStack {
                    HStack(spacing:20){
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text(currentUser.location)
                                .font(.callout)
                        }
                    
                    }
                    Spacer()
                    UserStatsView()
                        
                    
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
    
    
    
    var vinylFilterBar :some View {
        
        HStack{
            ForEach(ProfileFilterViewModel.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold: .regular)
                        .foregroundColor(selectedFilter == item ? .purple :.secondary)
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
    
    
    var vinylsInProfileView : some View{
        ScrollView{
            LazyVStack{
                ForEach(getDataForSelectedFilter(), id: \.id){ dataItem in
                    ItemRowView(vinyl: dataItem)
                }
            }
        }
    }
    
}

