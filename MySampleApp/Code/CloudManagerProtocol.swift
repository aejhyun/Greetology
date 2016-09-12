//
//  CloudProtocol.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation

protocol CloudManagerProtocol {
    
    func handleFacebookLogIn(completionHandler: (logInSuccessful: Bool) -> Void)
    func userIsLoggedIn() -> Bool
    func logOutUser(completionHandler: (result: AnyObject?, error: NSError?) -> Void)
    
}