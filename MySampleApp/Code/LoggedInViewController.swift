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
    var output: AWSDynamoDBPaginatedOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
 
    }
    
    @IBAction func pagiationButtonTapped(sender: AnyObject) {
        
        output?.loadNextPage()
        print(output?.items)
        
        
    }
    @IBAction func testingButtonTapped(sender: AnyObject) {
        
        var userId: AnyObject = manager.getUserId()
        var articleId: AnyObject = "24324"
        var author: AnyObject = "Bob Kim"
        
//        AWSManager().scanWithCompletionHandler({ (response, error) in
//            self.output = response
//        })
//            

        
        manager.scanDatabase("", scanLimit: 5) { (response, error) in
            self.output = response

        }
        
//        let data: [String: AnyObject] = ["userId": userId, "articleId": articleId, "author": author]
//        manager.saveDataInDatabase("News", data: data) { (savedDataSuccessfully) in
//            if savedDataSuccessfully {
//                print("hurrrrr")
//            }
//        }
        

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
