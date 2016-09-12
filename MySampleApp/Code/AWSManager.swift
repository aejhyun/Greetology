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

class AWSManager: CloudProtocol {
    
    static let sharedInstance: AWSManager = AWSManager()
    var delegate: AWSLogInObserverDelegate?
    
    var didSignInObserver: AnyObject!
    
    init() {
        NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            
            print("hello")
            self.delegate?.AWSLogInSuccessful()
        })
        AWSFacebookSignInProvider.sharedInstance().setPermissions(["public_profile"]);
    }
    
    //Ask Steve
    func didSignIn(completionHandler: (logInSuccessful: Bool) -> Void) {
        

    }
    
    func handleFacebookLogin(completionHandler: (logInSuccessful: Bool) -> Void) {
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
    
}