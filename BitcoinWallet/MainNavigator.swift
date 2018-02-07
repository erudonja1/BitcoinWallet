//
//  MainNavigator.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

protocol MainNavigation: class{
    func loginSucceded()
    func registrationFinished()
    
    func goToResetPin()
    func resetFinished()
    
    func closeApplication()
}



class MainNavigator: UINavigationController, MainNavigation{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if user logs in for the first time, navigate him to registration
        if userNotRegistered(){
            self.openRegistrationScreen()
        }else{
            self.openLoginScreen()
        }
    }
    
    func goToResetPin() {
        openResetPinScreen()
    }
    
    func resetFinished() {
        self.popViewController(animated: false)
        self.openHomeScreen()
    }
    
    func loginSucceded(){
        self.dismiss(animated: true, completion: nil)
        self.openHomeScreen()
    }
    
    func registrationFinished(){
        self.dismiss(animated: true, completion: nil)
        self.openHomeScreen()
    }
    
    func closeApplication(){
        // this is defined by requirement but is wrong.
        exit(0)
        
        // NOTE: this shouldn't be done like this, because APPLE store will reject it. By official documentation you shouldn't exit application because of User experience. You should suspend it only with example like bellow
        // UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    private func userNotRegistered() -> Bool{
        return UserManager().userNotRegistered()
    }
    
    private func openLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            destinationViewController.navigationDelegate = self as MainNavigation
            DispatchQueue.main.async {
                self.present(destinationViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func openRegistrationScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Registration", bundle: nil)
        if let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController{
            destinationViewController.navigationDelegate = self as MainNavigation
            
            DispatchQueue.main.async {
                self.present(destinationViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func openHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
            destinationViewController.navigationDelegate = self as MainNavigation
            self.setViewControllers([destinationViewController], animated: true)
        }
    }
    
    private func openResetPinScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "ResetPin", bundle: nil)
        if let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPinViewController") as? ResetPinViewController{
            destinationViewController.navigationDelegate = self as MainNavigation
            self.dismiss(animated: false, completion: nil)
            self.pushViewController(destinationViewController, animated: true)
        }
    }
    
    
}
