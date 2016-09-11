//
//  LoggedInViewController.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/31/16.
//
//

import UIKit
import AWSMobileHubHelper
import AWSCognito
import AWSDynamoDB

class LoggedInViewController: UIViewController {
  
    let currentUser = CurrentUser.sharedInstance
    let setter: ViewControllerSetter = ViewControllerSetter.sharedInstance
    let cognitoManager = AWSCognitoManager.sharedInstance
    
    let AWSSampleDynamoDBTableName = "DynamoDB-OM-SwiftSample"

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()        
        
 
    }
    


    @IBAction func setBannerButtonTapped(sender: AnyObject) {
//        let currentLocation = Location()
//        let currentTime = Time().getCurrentTime()
//        let currentDate = Date().getCurrentDate()
        
        
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if (currentUser.loggedIn()) {
            currentUser.logOut({ (result, error) in
                self.setter.setLogInAndSignUpViewController(self)
                
            })
            print("Logout Successful: )");
            
            
        } else {
            assert(false)
        }
    }
    
    func handleLogout() {
        
        
        
        
        
    }

}
