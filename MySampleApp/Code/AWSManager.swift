//
//  AWSManager.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation
import UIKit
import AWSMobileHubHelper
import FBSDKLoginKit

class AWSManager: CloudManagerProtocol {
    
    static let sharedInstance: AWSManager = AWSManager()
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
    
    func logOutUser(completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        AWSIdentityManager.defaultIdentityManager().logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
            completionHandler(result: result, error: error)
        })
    }
    
    func handleFacebookLogIn(completionHandler: (logInSuccessful: Bool) -> Void) {
        handleLogInWithSignInProvider(AWSFacebookSignInProvider.sharedInstance()) { (signInProviderLogInSuccessful) in
            if signInProviderLogInSuccessful {
                completionHandler(logInSuccessful: true)
            }
        }
    }
    
    private func handleLogInWithSignInProvider(signInProvider: AWSSignInProvider, completionHandler: (signInProviderLogInSuccessful: Bool) -> Void) {
        AWSIdentityManager.defaultIdentityManager().loginWithSignInProvider(signInProvider, completionHandler: {(result: AnyObject?, error: NSError?) -> Void in
            if error == nil {
                completionHandler(signInProviderLogInSuccessful: true)
            }
            print("result = \(result), error = \(error)")
        })
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(didSignInObserver)
    }
    
}

protocol AWSLogInObserverDelegate {
    func AWSLogInSuccessful() -> Void
}