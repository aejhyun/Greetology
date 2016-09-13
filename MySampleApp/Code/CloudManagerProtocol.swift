//
//  CloudProtocol.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation
import AWSDynamoDB

protocol CloudManagerProtocol {
    
    func getUserId() -> String
    
    func handleFacebookLogIn(completionHandler: (loggedInSuccessfully: Bool) -> Void)
    
    func userIsLoggedIn() -> Bool
    
    func handleLogOut(completionHandler: (loggedOutSuccessfully: Bool) -> Void)
    
    
    func saveItemsInDatabase(tableName: String, items: [String: AnyObject?], completionHandler: (savedItemsSuccessfully: Bool) -> Void)
    
    func getItemFromDatabase(tableName: String, hashKey: String, rangeKey: String, completionHandler: (gotItemSuccessfully: Bool, item: AWSDynamoDBObjectModel?) -> Void)
    
    
    
    
    
    
}