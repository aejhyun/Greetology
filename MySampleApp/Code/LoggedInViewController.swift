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
    
    @IBOutlet weak var searchKeywordsTextField: UITextField!
    let setter: ViewControllerSetter = ViewControllerSetter.sharedInstance
    let manager: BackEndManager = AWSManager.sharedInstance
    var numOfPosts: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.loadUserSettings("userSettings") { (userSettings, error) in
            if error != nil {
                print("erroryo")
                return
            }
            self.numOfPosts = userSettings.stringForKey("numOfPosts")
            if self.numOfPosts == nil {
                self.numOfPosts = 0
            } else {
                self.incrementNumOfPosts()
            }
        }
    }
    
    func incrementNumOfPosts() {
        var numOfPosts = self.numOfPosts! as! Int
        numOfPosts += 1
        self.numOfPosts = String(numOfPosts)
    }
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        guard let keywords = searchKeywordsTextField.text where searchKeywordsTextField.text != nil else {
            return
        }
        let formattedKeywords = getFormattedKeywords(keywords)
        
        manager.saveUserSettings("userSettings", userSettings: ["numOfPosts": self.numOfPosts as! String]) { (result, error) in
            
        }

        
        
        
        
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
    
    func getFormattedKeywords(keywords: String) -> [String] {
        var keywordsArray = keywords.componentsSeparatedByString("#")
        keywordsArray = keywordsArray.sort()
        keywordsArray.removeAtIndex(0)
        print(keywordsArray)
        for index in 0..<keywordsArray.count {
            keywordsArray[index] = keywordsArray[index].lowercaseString
        }
        return keywordsArray
    }

}
