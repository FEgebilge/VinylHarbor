//
//  FeedView.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 29.12.2023.
//
/*
import SwiftUI

struct FeedView: View {
    @State private var showNewTweetPanel=false
    @State private var vinyls: [Vinyl] = []
    
    var body: some View {
        ZStack (alignment:.bottomTrailing){
            ScrollView{
                LazyVStack{
                    ForEach(vinyls, id: \.id) { vinyl in
                        NavigationLink {
                            ItemFullView(vinyl: vinyl)
                        }label:{
                            ItemRowView(vinyl:vinyl)
                                
                        }
                        .padding(15)
                        
                        
                    }
                }
            }
            
            Button {
                showNewTweetPanel.toggle()
            } label: {
                
           Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(9)
                    
            }
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetPanel) {
                NewItemView()
            }
            
        }
        .onAppear {
                    // Fetch vinyl records from the database when the view appears
                    vinyls = DatabaseManager.getVinyls() // Fetch vinyls using your database manager
                }
    }
}

#Preview {
    FeedView()
}
*/
