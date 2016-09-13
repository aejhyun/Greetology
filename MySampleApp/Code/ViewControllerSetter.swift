//
//  ViewControllerSetter.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/10/16.
//
//

import UIKit

class ViewControllerSetter: UIViewController {
    
    static let sharedInstance: ViewControllerSetter = ViewControllerSetter()
    private var window: UIWindow?
    
    func setLogInAndSignUpViewControllerInAppDelegate() {
        setViewControllerInAppDelegate("LogInAndSignUp", viewControllerID: "LogInAndSignUpViewController")
    }
    
    func setLoggedInViewControllerInAppDelegate() {
        setViewControllerInAppDelegate("Main", viewControllerID: "LoggedInViewController")
    }
    
    func setLoggedInViewController(presentingViewController: UIViewController) {
        setViewController("Main", viewControllerID: "LoggedInViewController", presentingViewController: presentingViewController)
    }
    
    private func instantiateViewController(storyboardName: String, viewControllerID: String) -> UIViewController{
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let instantiatedViewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerID)
        return instantiatedViewController
    }
    
    private func setRootViewControllerWith(instantiatedViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = instantiatedViewController
        window?.makeKeyAndVisible()
    }
    
    private func setViewControllerInAppDelegate(storyboardName: String, viewControllerID: String) {
        let instantiatedViewController = instantiateViewController(storyboardName, viewControllerID: viewControllerID)
        setRootViewControllerWith(instantiatedViewController)
    }
    
    private func setViewController(storyboardName: String, viewControllerID: String, presentingViewController: UIViewController) {
        let instantiatedViewController = instantiateViewController(storyboardName, viewControllerID: viewControllerID)
        presentingViewController.presentViewController(instantiatedViewController, animated: true, completion: nil)
    }

}
