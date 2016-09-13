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
  
        
        
 
    }
    
    @IBAction func testingButtonTapped(sender: AnyObject) {
        
        var userId: AnyObject = manager.getUserId()
        var articleId: AnyObject = "24324"
        var author: AnyObject = "Bob Kim"
        
        
        
        let data: [String: AnyObject] = ["userId": userId, "articleId": articleId, "author": author]
        manager.saveDataInDatabase("News", data: data) { (savedDataSuccessfully) in
            if savedDataSuccessfully {
                print("hurrrrr")
            }
        }
        
//        AWSManager().insertSampleDataWithCompletionHandler { (errors) in
//            
//        }
        
//        AWSManager().getItemWithCompletionHandler { (response, error) in
//            if let response = response {
//                let dictionaryValue = response.dictionaryValue
//                print(dictionaryValue)
//                
//                let value = Mirror(reflecting: dictionaryValue["test"])
//                print(value)
//                let v = dictionaryValue["test"] as! [String]
//                print(v)
//                
//            }
//        
//        }
        
//        manager.insertSampleDataWithCompletionHandler { (errors) in
//            print("YASS")
//        }
        
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
