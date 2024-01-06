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

    static func insertVinyl(title: String, artist: String, releaseDate: Date, genre: String, condition: String, coverCondition: String, price: Double,description: String, sellerID: Int, customerID:Int, onSell:Int) {
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
        let customerIDExpression = Expression<Int>("CustomerID")
        let onSellExpression = Expression<Int>("OnSell")
        
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
                sellerIDExpression <- sellerID,
                customerIDExpression <- customerID,
                onSellExpression <- onSell
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
            let onSell = Expression<Int>("OnSell")
            
            // Define the search filter
            var query = vinylTable.filter(onSell==1)
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
                    CustomerID: row[customerID],
                    OnSell: row[onSell]
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

          let users = Table("User")
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
              let bookmarkedVinylsString = try JSONSerialization.data(withJSONObject: bookmarkedVinyls, options: [])
                      let bookmarkedVinylsEncoded = String(data: bookmarkedVinylsString, encoding: .utf8) ?? ""
              try db.run(users.insert(
                  usernameExp <- username,
                  nameExp <- name,
                  emailExp <- email,
                  phoneExp <- phone,
                  billingAddressExp <- billingAddress,
                  shippingAddressExp <- shippingAddress,
                  locationExp <- location,
                  bookmarkedVinylsExp <- bookmarkedVinylsEncoded,
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
        

 
    struct User: Codable {
        var userID: Int
        var username: String
        var name:String
        var email:String
        var phone: String
        var billingAddress: String
        var shippingAddress: String
        var location: String
        var bookmarkedVinyls: [Int]
        var sellerRating: Double
        var customerRating: Double
        var description: String
        // ... other user properties
        
        enum CodingKeys:String, CodingKey{
            case userID = "UserID"
            case username = "Username"
            case name = "Name"
            case email = "Email"
            case phone = "Phone"
            case billingAddress = "BillingAddress"
            case shippingAddress = "ShippingAddress"
            case location = "Location"
            case bookmarkedVinyls = "BookmarkedVinyls"
            case sellerRating = "SellerRating"
            case customerRating = "CustomerRating"
            case description = "Description"
        }
    }

    static func authenticateUser(username: String, password: String) -> User? {
        let users = Table("User")
        let userIDColumn = Expression<Int>("UserID")
        let usernameColumn = Expression<String>("Username")
        let nameColumn = Expression<String>("Name")
        let emailColumn = Expression<String>("Email")
        let phoneColumn = Expression<String>("Phone")
        let billingAddressColumn = Expression<String>("BillingAddress")
        let shippingAddressColumn = Expression<String>("ShippingAddress")
        let locationColumn = Expression<String>("Location")
        let bookmarkedVinylsColumn = Expression<String>("BookmarkedVinyls") // Stored as a String or JSON format
        let sellerRatingColumn = Expression<Double>("SellerRating")
        let customerRatingColumn = Expression<Double>("CustomerRating")
        let descriptionColumn = Expression<String>("Description")
        let passwordColumn = Expression<String>("Password")

        
        let query = users.filter(usernameColumn == username && passwordColumn == password)

        do {
          
            if let userRow = try db.pluck(query) {
                
                let bookmarkedVinylsString = userRow[bookmarkedVinylsColumn]
                let bookmarkedVinylsData = bookmarkedVinylsString.data(using: .utf8) ?? Data()
                let bookmarkedVinylsArray = try JSONDecoder().decode([Int].self, from: bookmarkedVinylsData)
                
                let user = User(userID:  userRow[userIDColumn], username: userRow[usernameColumn], name: userRow[nameColumn], email: userRow[emailColumn], phone: userRow[phoneColumn], billingAddress: userRow[billingAddressColumn], shippingAddress: userRow[shippingAddressColumn], location: userRow[locationColumn], bookmarkedVinyls:bookmarkedVinylsArray, sellerRating: userRow[sellerRatingColumn], customerRating: userRow[customerRatingColumn], description: userRow[descriptionColumn])
                return user
                
            } else {
                // Authentication failed
                
                print("Username or password is wrong")
                return nil
            }
        } catch {
            // Handle any potential errors
            print("Error authenticating user: \(error)")
            return nil
        }
    }
    
    static func getVinylsForSellerID(currentUserID: Int) -> [Vinyl] {
        
        var vinyls: [Vinyl] = []

        do {
            // Replace "path_to_your_database" with the actual path to your SQLite database file
            let db = try Connection(dbPath)
            
            let vinylsTable = Table("Vinyl")
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
            let onSell = Expression<Int>("OnSell")
            // Define expressions for other columns

            let filteredVinyls = vinylsTable.filter(onSell==1 && currentUserID == sellerID )

            for row in try db.prepare(filteredVinyls) {
                let newVinyl = Vinyl(
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
                    CustomerID: row[customerID],
                    OnSell: row[onSell]
                )
                vinyls.append(newVinyl)
            }
        } catch {
            print("Error fetching vinyls: \(error)")
        }

        return vinyls
    }
    
    static func getVinylsBought(currentUserID: Int) -> [Vinyl] {
        
        var vinyls: [Vinyl] = []

        do {
            // Replace "path_to_your_database" with the actual path to your SQLite database file
            let db = try Connection(dbPath)
            
            let vinylsTable = Table("Vinyl")
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
            let onSell = Expression<Int>("OnSell")
            // Define expressions for other columns

            let filteredVinyls = vinylsTable.filter(currentUserID == customerID )

            for row in try db.prepare(filteredVinyls) {
                let newVinyl = Vinyl(
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
                    CustomerID: row[customerID],
                    OnSell: row[onSell]
                )
                vinyls.append(newVinyl)
            }
        } catch {
            print("Error fetching vinyls: \(error)")
        }

        return vinyls
    }
    
    static func deleteVinylRecord(deleteID: Int) throws {
        let vinyls = Table("Vinyl")
        let vinylID = Expression<Int>("VinylID")
        print(vinylID)
        let recordToDelete = vinyls.filter(vinylID == deleteID)
        
        do {
            let db = try Connection(dbPath)
            let deletedRows = try db.run(recordToDelete.delete())
            
            // Print the number of deleted rows for confirmation
            print("Deleted \(deletedRows) rows")
        } catch {
            // Print the error description if an error occurs
            print("Error deleting record: \(error.localizedDescription)")
            throw error
        }
    }
    
    static func sellVinyl(SellID: Int, CurrentUserID:Int) throws{
        let vinyls = Table("Vinyl")
        let vinylID = Expression<Int>("VinylID")
        let onSellColumn = Expression<Int>("OnSell")
        var customerID = Expression<Int>("CustomerID")
        print(vinylID)
        let recordToSell = vinyls.filter(vinylID == SellID)
        
        do {
            let db = try Connection(dbPath)
            let update = recordToSell.update(onSellColumn <- 0)
            let update2 = recordToSell.update(customerID <- CurrentUserID)
          //Change the recordToSells on sell value to 0 in that line
            try db.run(update)
            try db.run(update2)
        } catch {
            print("Error deleting record: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    struct Transaction {
        var transactionID: Int
        var vinylID: Int
        var customerID: Int
        var sellerID: Int
        var transactionDate: String
        var transactionAmount: Double
    }

   
    static func insertTransaction(vinylID: Int, customerID: Int, sellerID: Int, transactionDate: Date, transactionAmount: Double) {
        do {
            let db = try Connection(dbPath)
            let transactionTable = Table("Transaction_Vinyl")
            
            let transactionIDExpression = Expression<Int>("TransactionID")
            let vinylIDExpression = Expression<Int>("VinylID")
            let customerIDExpression = Expression<Int>("CustomerID")
            let sellerIDExpression = Expression<Int>("SellerID")
            let transactionDateExpression = Expression<Date>("TransactionDate")
            let transactionAmountExpression = Expression<Double>("TransactionAmount")
           
            
            // Insert the data into the Transaction table
            try db.run(transactionTable.insert(
                vinylIDExpression <- vinylID,
                customerIDExpression <- customerID,
                sellerIDExpression <- sellerID,
                transactionDateExpression <- transactionDate,
                transactionAmountExpression <- transactionAmount
            ))
            
            print("Data inserted successfully.")
        } catch {
            print("Error inserting data: \(error)")
        }
    }

   

    // Implement other database operations like querying, updating, deleting, etc.
}

