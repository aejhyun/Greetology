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
    
    var didSignInObserver: AnyObject!
    var signOutObserver: AnyObject!
    let manager = AWSManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
    
        didSignInObserver =  NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            
            })
        
    }
 
    @IBAction func facebookButtonTapped(sender: AnyObject) {
        manager.handleFacebookLogin { (facebookLogInSuccessful) in
            if facebookLogInSuccessful {
                
            }
        }
    }

    //AWSLogInObserverDelegate function
    func AWSLogInSuccessful() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoggedInViewController")
        self.presentViewController(vc, animated: true, completion: nil)

        
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(didSignInObserver)
    }
    

    
}
