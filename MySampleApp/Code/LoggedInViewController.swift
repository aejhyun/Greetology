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
    let cognitoManager = AWSCognitoManager.sharedInstance
    
    let AWSSampleDynamoDBTableName = "DynamoDB-OM-SwiftSample"

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()        
        
 
    }
    
    func setLogInAndSignUpViewController() {
        let storyboard = UIStoryboard(name: "LogInAndSignUp", bundle: nil)
        let logInAndSignUpViewController = storyboard.instantiateViewControllerWithIdentifier("LogInAndSignUpViewController")
        self.presentViewController(logInAndSignUpViewController, animated: true, completion: nil)
    }

    @IBAction func setBannerButtonTapped(sender: AnyObject) {
//        let currentLocation = Location()
//        let currentTime = Time().getCurrentTime()
//        let currentDate = Date().getCurrentDate()
        
        
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if (currentUser.loggedIn()) {
            currentUser.logOut({ (result, error) in
                //self.setLogInAndSignUpViewController()
                
            })
            print("Logout Successful: )");
            
            
        } else {
            assert(false)
        }
    }
    
    func handleLogout() {
        
        
        
        
        
    }

}
