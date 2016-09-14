//
//  AWSManager.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation
import UIKit
import AWSCognito
import AWSDynamoDB
import AWSMobileHubHelper
import FBSDKLoginKit

class AWSManager: BackEndManager {
    
    static let sharedInstance: AWSManager = AWSManager()
    let tableFactory = AWSDynamoDBTableFactory.sharedInstance
    let identityManager = AWSIdentityManager.defaultIdentityManager()
    let cognito: AWSCognito = AWSCognito.defaultCognito()
    let dynamoDB = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
    var delegate: AWSLogInObserverDelegate?
    
    var didSignInObserver: AnyObject!
    
    init() {
        
        didSignInObserver = NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            
            self.delegate?.AWSLogInSuccessful()
        })
        AWSFacebookSignInProvider.sharedInstance().setPermissions(["public_profile"]);
    }
    
    func userIsLoggedIn() -> Bool {
        return identityManager.loggedIn
    }
    
    func getUserId() -> String {
        return identityManager.identityId!
    }
    
    func handleLogOut(completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        identityManager.logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
            completionHandler(result: result, error: error)
        })
    }
    
    func handleFacebookLogIn(completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        handleLogInWithSignInProvider(AWSFacebookSignInProvider.sharedInstance()) { (result, error) in
            completionHandler(result: result, error: error)
        }
    }
    
    private func handleLogInWithSignInProvider(signInProvider: AWSSignInProvider, completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        identityManager.loginWithSignInProvider(signInProvider, completionHandler: {(result: AnyObject?, error: NSError?) -> Void in
            completionHandler(result: result, error: error)
        })
    }
    
    func saveUserSettings(dataSetName: String, userSettings: [String: String], completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        let dataSet: AWSCognitoDataset = cognito.openOrCreateDataset(dataSetName)
        for (key, value) in userSettings {
            dataSet.setString(value, forKey: key)
        }
        dataSet.synchronize().continueWithExceptionCheckingBlock({(result: AnyObject?, error: NSError?) -> Void in
            completionHandler(result: result, error: error)
        })
    }
    
    func loadUserSettings(dataSetName: String, completionHandler: (userSettings: AWSCognitoDataset, error: NSError?) -> Void) {
        let userSettings: AWSCognitoDataset = cognito.openOrCreateDataset(dataSetName)
        userSettings.synchronize().continueWithExceptionCheckingBlock { (result, error) in
            completionHandler(userSettings: userSettings, error: error)
        }
    }
    
    func saveItemsInDatabase(tableName: String, items: [String: AnyObject?], completionHandler: (error: NSError?) -> Void) {
        let tableFromFactory = tableFactory.getTable(tableName)
        guard let table = tableFromFactory where tableFromFactory != nil else {
            print("Table returned nil")
            return
        }
        table.setItemForKeyForTable(items)
        dynamoDB.save(table.returnDynamoDBObjectModel(), completionHandler: {(error: NSError?) -> Void in
            completionHandler(error: error)
        })
    }
    
    func getItemFromDatabase(tableName: String, hashKey: String, rangeKey: String, completionHandler: (item: AWSDynamoDBObjectModel?, error: NSError?) -> Void) {
        let tableFromFactory = tableFactory.getTable(tableName)
        guard let table = tableFromFactory where tableFromFactory != nil else {
            print("Table returned nil")
            return
        }
        dynamoDB.load(table.returnAnyClass(), hashKey: hashKey, rangeKey: rangeKey) { (item: AWSDynamoDBObjectModel?, error: NSError?) in
            completionHandler(item: item, error: error)
        }
    }
    
    func updateItemInDatabase(tableName: String, items: [String: AnyObject?], completionHandler: (error: NSError?) -> Void) {

        
    }
    
    func queryWithPartitionKeyFromDatabase(tableName: String, partitionKey: String, completionHandler: (response: AWSDynamoDBPaginatedOutput?, error: NSError?) -> Void) {
        
        let tableFromFactory = tableFactory.getTable(tableName)
        guard let table = tableFromFactory where tableFromFactory != nil else {
            print("Table returned nil")
            return
        }
        
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.keyConditionExpression = "#userId = :userId"
        queryExpression.expressionAttributeNames = ["#userId": "userId",]
        queryExpression.expressionAttributeValues = [":userId": partitionKey,]
        
        dynamoDB.query(table.returnAnyClass(), expression: queryExpression) { (response: AWSDynamoDBPaginatedOutput?, error: NSError?) in
            completionHandler(response: response, error: error)
        }
    }
    
    func scanDatabase(tableName: String, scanLimit: Int, completionHandler: (response: AWSDynamoDBPaginatedOutput?, error: NSError?) -> Void) {
        
        let tableFromFactory = tableFactory.getTable(tableName)
        guard let table = tableFromFactory where tableFromFactory != nil else {
            print("Table returned nil")
            return
        }
        
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.limit = scanLimit
        
        dynamoDB.scan(table.returnAnyClass(), expression: scanExpression, completionHandler: {(response: AWSDynamoDBPaginatedOutput?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(response: response, error: error)
            })
        })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(didSignInObserver)
    }
    
}

protocol AWSLogInObserverDelegate {
    func AWSLogInSuccessful() -> Void
}