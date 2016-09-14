//
//  CloudProtocol.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation
import AWSCognito
import AWSDynamoDB

protocol BackEndManager {
    
    func getUserId() -> String
    
    func handleFacebookLogIn(completionHandler: (result: AnyObject?, error: NSError?) -> Void)
    
    func userIsLoggedIn() -> Bool
    
    func handleLogOut(completionHandler: (result: AnyObject?, error: NSError?) -> Void)
    
    func saveUserSettings(dataSetName: String, userSettings: [String: String], completionHandler: (result: AnyObject?, error: NSError?) -> Void)
    
    func loadUserSettings(dataSetName: String, completionHandler: (userSettings: AWSCognitoDataset, error: NSError?) -> Void)
    
    func saveItemsInDatabase(tableName: String, items: [String: AnyObject?], completionHandler: (error: NSError?) -> Void)
    
    func getItemFromDatabase(tableName: String, hashKey: String, rangeKey: String, completionHandler: (item: AWSDynamoDBObjectModel?, error: NSError?) -> Void)
    
    func scanDatabase(tableName: String, scanLimit: Int, completionHandler: (response: AWSDynamoDBPaginatedOutput?, error: NSError?) -> Void)

}