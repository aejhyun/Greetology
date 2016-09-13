//
//  CloudProtocol.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation

protocol CloudManagerProtocol {
    
    func getUserId() -> String
    
    func handleFacebookLogIn(completionHandler: (loggedInSuccessfully: Bool) -> Void)
    
    func userIsLoggedIn() -> Bool
    
    func handleLogOut(completionHandler: (loggedOutSuccessfully: Bool) -> Void)
    
    func saveDataInDatabase(tableName: String, data: [String: AnyObject?], completionHandler: (savedDataSuccessfully: Bool) -> Void)
    
    
    
    
    
    
}