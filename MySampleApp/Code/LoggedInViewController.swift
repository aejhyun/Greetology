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
  
    let setter: ViewControllerSetter = ViewControllerSetter.sharedInstance
    let manager: CloudManagerProtocol = AWSManager.sharedInstance
    
    let AWSSampleDynamoDBTableName = "DynamoDB-OM-SwiftSample"

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()        
        
 
    }
    
    @IBAction func testingButtonTapped(sender: AnyObject) {
 

        
        
    }

    @IBAction func setBannerButtonTapped(sender: AnyObject) {
//        let currentLocation = Location()
//        let currentTime = Time().getCurrentTime()
//        let currentDate = Date().getCurrentDate()
        
        
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if (manager.userIsLoggedIn()) {
            manager.handleLogOut({ (loggedOutSuccessfully) in
                if loggedOutSuccessfully {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
            print("Logout Successful: )");
        } else {
            assert(false)
        }
    }

}
