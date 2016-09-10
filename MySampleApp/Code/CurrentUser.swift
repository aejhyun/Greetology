//
//  CurrentUser.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 9/5/16.
//
//

import Foundation
import AWSMobileHubHelper

class CurrentUser {
    
    static let sharedInstance: CurrentUser = CurrentUser()
    
    func loggedIn() -> Bool {
        return AWSIdentityManager.defaultIdentityManager().loggedIn
    }
    
    func logOut(completionHandler: (result: AnyObject?, error: NSError?) -> Void) {
        AWSIdentityManager.defaultIdentityManager().logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
            
            completionHandler(result: result, error: error)
            
        })

    }
    
    
}