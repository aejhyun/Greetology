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
import AWSMobileHubHelper
import FBSDKLoginKit

class AWSManager: CloudManagerProtocol {
    
    static let sharedInstance: AWSManager = AWSManager()
    let cognito: AWSCognito = AWSCognito.defaultCognito()
    var delegate: AWSLogInObserverDelegate?
    
    var didSignInObserver: AnyObject!
    
    init() {
        
        didSignInObserver = NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            
            self.delegate?.AWSLogInSuccessful()
        })
        AWSFacebookSignInProvider.sharedInstance().setPermissions(["public_profile"]);
    }
    
    func userIsLoggedIn() -> Bool {
        return AWSIdentityManager.defaultIdentityManager().loggedIn
    }
    
    func handleLogOut(completionHandler: (loggedOutSuccessfully: Bool) -> Void) {
        AWSIdentityManager.defaultIdentityManager().logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                completionHandler(loggedOutSuccessfully: true)
            }
            print(error)
        })
    }
    
    func handleFacebookLogIn(completionHandler: (loggedInSuccessfully: Bool) -> Void) {
        handleLogInWithSignInProvider(AWSFacebookSignInProvider.sharedInstance()) { (signInProviderLoggedInSuccessfully) in
            if signInProviderLoggedInSuccessfully {
                completionHandler(loggedInSuccessfully: true)
            }
        }
    }
    
    private func handleLogInWithSignInProvider(signInProvider: AWSSignInProvider, completionHandler: (signInProviderLoggedInSuccessfully: Bool) -> Void) {
        AWSIdentityManager.defaultIdentityManager().loginWithSignInProvider(signInProvider, completionHandler: {(result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                completionHandler(signInProviderLoggedInSuccessfully: true)
            }
            print("result = \(result), error = \(error)")
        })
    }
    
    func saveUserSettings(dataSetName: String, userSettings: [String: String], completionHandler: (userSettingsSavedSuccessfuly: Bool) -> Void) {
        let dataSet: AWSCognitoDataset = cognito.openOrCreateDataset(dataSetName)
        for (key, value) in userSettings {
            dataSet.setString(value, forKey: key)
        }
        dataSet.synchronize().continueWithExceptionCheckingBlock({(result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                completionHandler(userSettingsSavedSuccessfuly: true)
            } else {
                print("saveSettings AWS task error: \(error!.localizedDescription)")
            }
        })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(didSignInObserver)
    }
    
}

protocol AWSLogInObserverDelegate {
    func AWSLogInSuccessful() -> Void
}