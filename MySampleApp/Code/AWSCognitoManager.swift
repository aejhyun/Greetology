//
//  AWSManager.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 9/5/16.
//
//

import Foundation
import AWSCognito

class AWSCognitoManager {

    static let sharedInstance: AWSCognitoManager = AWSCognitoManager()
    
    func wipeCachedData() {
        AWSCognito.defaultCognito().wipe()
    }
    
    func saveToCognito(objectsToSaveToCognito objects: [String: AnyObject?], datasetKey: String) {
        let syncClient: AWSCognito = AWSCognito.defaultCognito()
        let userInformation: AWSCognitoDataset = syncClient.openOrCreateDataset(datasetKey)
        for (key, object) in objects {
            
            userInformation.setValue(object, forKey: key)
            print("hello")
        }
        userInformation.synchronize().continueWithExceptionCheckingBlock({(result: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                print("saveSettings AWS task error: \(error.localizedDescription)")
            }
        })
    }
    
}