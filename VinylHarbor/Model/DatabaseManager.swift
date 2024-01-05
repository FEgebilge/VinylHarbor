//
//  DatabaseManager.swift
//  VinylHarbor
//
//  Created by Ege Bilge on 2.01.2024.
//

import Foundation
import SQLite
var dbPath="/Users/egebilge/Developer/VinylHarbor/VinylHarborSQLite.db"

struct DatabaseManager {
    // Define a connection to the SQLite database
    static let db = try! Connection(dbPath)

    static func createTables() {
        // Code to create tables
    }

    static func insertVinyl(title: String, artist: String, releaseDate: Date, genre: String, condition: String, coverCondition: String, price: Double,description: String, sellerID: Int) {
        let vinyls = Table("Vinyl")
        let vinylID = Expression<Int64>("VinylID")
        let titleExpression = Expression<String>("Title")
        let artistExpression = Expression<String>("Artist")
        let releaseDateExpression = Expression<Date>("ReleaseDate")
        let genreExpression = Expression<String>("Genre")
        let conditionExpression = Expression<String>("Condition")
        let coverConditionExpression = Expression<String>("CoverCondition")
        let priceExpression = Expression<Double>("Price")
        let descriptionExpression = Expression<String>("Description")
        let sellerIDExpression = Expression<Int>("SellerID")

        do {
            try db.run(vinyls.insert(
                titleExpression <- title,
                artistExpression <- artist,
                releaseDateExpression <- releaseDate,
                genreExpression <- genre,
                conditionExpression <- condition,
                coverConditionExpression <- coverCondition,
                priceExpression <- price,
                descriptionExpression <- description,
                sellerIDExpression <- sellerID
            ))
            print("Inserted Vinyl into Vinyls table")
        } catch {
            print(error)
        }
    }
    
    static func getVinyls(searchText: String) throws -> [Vinyl] {
        var vinyls: [Vinyl] = []
        
        do {
            let db = try Connection(dbPath)
            let vinylTable = Table("Vinyl") // Replace with your table name
            
            // Define columns
            let vinylID = Expression<Int>("VinylID")
            let title = Expression<String>("Title")
            let artist = Expression<String>("Artist")
            let releaseDate = Expression<Date>("ReleaseDate")
            let genre = Expression<String>("Genre")
            let condition = Expression<String>("Condition")
            let coverCondition = Expression<String>("CoverCondition")
            let price = Expression<Double>("Price")
            let description = Expression<String>("Description")
            let sellerID = Expression<Int>("SellerID")
            let customerID = Expression<Int>("CustomerID")
            
            // Define the search filter
            var query = vinylTable
            if !searchText.isEmpty {
                query = query.filter(title.like("%\(searchText)%") || artist.like("%\(searchText)%"))
            }
            
            for row in try db.prepare(query) {
                let vinyl = Vinyl(
                    id: row[vinylID],
                    Title: row[title],
                    Artist: row[artist],
                    ReleaseDate: row[releaseDate],
                    Genre: row[genre],
                    Condition: row[condition],
                    CoverCondition: row[coverCondition],
                    Price: row[price],
                    Description: row[description],
                    SellerID: row[sellerID],
                    CustomerID: row[customerID]
                )
                vinyls.append(vinyl)
            }
            print("Retrieved Vinyls:", vinyls)
        } catch {
            print("Error: \(error)")
            throw error
        }
        
        return vinyls
    }

    static func createUser(username: String,
                             name: String,
                             email: String,
                             phone: String,
                             billingAddress: String,
                             shippingAddress: String,
                             location: String,
                             bookmarkedVinyls: [Int], // Assuming it's an array of Vinyl IDs
                             sellerRating: Double,
                             customerRating: Double,
                             description: String,
                             password: String) {

          let users = Table("Users")
          let userID = Expression<Int64>("UserID")
          let usernameExp = Expression<String>("Username")
          let nameExp = Expression<String>("Name")
          let emailExp = Expression<String>("Email")
          let phoneExp = Expression<String>("Phone")
          let billingAddressExp = Expression<String>("BillingAddress")
          let shippingAddressExp = Expression<String>("ShippingAddress")
          let locationExp = Expression<String>("Location")
          let bookmarkedVinylsExp = Expression<String>("BookmarkedVinyls") // Stored as a String or JSON format
          let sellerRatingExp = Expression<Double>("SellerRating")
          let customerRatingExp = Expression<Double>("CustomerRating")
          let descriptionExp = Expression<String>("Description")
          let passwordExp = Expression<String>("Password")

          do {
              try db.run(users.insert(
                  usernameExp <- username,
                  nameExp <- name,
                  emailExp <- email,
                  phoneExp <- phone,
                  billingAddressExp <- billingAddress,
                  shippingAddressExp <- shippingAddress,
                  locationExp <- location,
                  bookmarkedVinylsExp <- bookmarkedVinyls.map(String.init).joined(separator: ","),
                  sellerRatingExp <- sellerRating,
                  customerRatingExp <- customerRating,
                  descriptionExp <- description,
                  passwordExp <- password
              ))
              print("Inserted User into Users table")
          } catch {
              print("Insertion failed: \(error)")
          }
      }
        

       /* static func authenticateUser(username: String, password: String) -> Bool {
            // Check if user credentials exist in the database
            // Return true if authentication succeeds, false otherwise
        }
    */
    
    
    // Implement other database operations like querying, updating, deleting, etc.
}

