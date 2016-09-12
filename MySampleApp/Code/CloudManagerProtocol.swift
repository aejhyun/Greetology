//
//  CloudProtocol.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import Foundation

protocol CloudManagerProtocol {
    
    func handleFacebookLogIn(completionHandler: (loggedInSuccessfully: Bool) -> Void)
    
    func userIsLoggedIn() -> Bool
    
    func handleLogOut(completionHandler: (loggedOutSuccessfully: Bool) -> Void)
    
    func saveUserSettings(dataSetName: String, userSettings: [String: String], completionHandler: (userSettingsSavedSuccessfuly: Bool) -> Void)
    
}