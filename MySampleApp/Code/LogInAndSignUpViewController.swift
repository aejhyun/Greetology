//
//  LogInViewController.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/30/16.
//
//

import UIKit
import AWSMobileHubHelper
import FBSDKLoginKit

class LogInAndSignUpViewController: UIViewController, AWSLogInObserverDelegate {
    
    let manager: CloudManagerProtocol = AWSManager.sharedInstance
    let aWSManager: AWSManager = AWSManager.sharedInstance
    let setter: ViewControllerSetter = ViewControllerSetter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aWSManager.delegate = self
        
    }
 
    @IBAction func facebookButtonTapped(sender: AnyObject) {
        manager.handleFacebookLogIn { (result, error) in
            if error == nil {
                
            }
        }
    
    
    }

    //AWSLogInObserverDelegate function
    func AWSLogInSuccessful() -> Void {
        setter.setLoggedInViewController(self)
    }
    
    
    

    
}
