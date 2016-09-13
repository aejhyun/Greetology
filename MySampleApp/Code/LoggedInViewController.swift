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
  
    @IBOutlet weak var searchKeywords: UITextField!
    
    let setter: ViewControllerSetter = ViewControllerSetter.sharedInstance
    let manager: CloudManagerProtocol = AWSManager.sharedInstance
    let AWSSampleDynamoDBTableName = "DynamoDB-OM-SwiftSample"
    var output: AWSDynamoDBPaginatedOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    @IBAction func searchButtonTapped(sender: AnyObject) {
        
        
        
        
    }

    @IBAction func postButtonTapped(sender: AnyObject) {
        
        
        
        
    }
    @IBAction func setBannerButtonTapped(sender: AnyObject) {
//        let currentLocation = Location()
//        let currentTime = Time().getCurrentTime()
//        let currentDate = Date().getCurrentDate()
        
        
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        if (manager.userIsLoggedIn()) {
            manager.handleLogOut({ (result, error) in
                if error == nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }

}
