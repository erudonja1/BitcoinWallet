//
//  LoginViewController.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {

    weak var navigationDelegate: MainNavigation?
    private var viewModel: LoginViewModel?

    
    @IBOutlet weak var pinCodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel(output: self as LoginViewProtocol)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        viewModel?.login(pinCode: pinCodeTextField.text ?? "")
    }

    func loginSucceded() {
        // tell the navigation Delegate that login succeded
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.loginSucceded()
        }
    }
    
    func loginFailed(errorMessage: String) {
        AlertCenter.show(title: "Error", message: errorMessage, buttonText: "Ok", viewController: self)
    }
    
    func noMoreLoginAttempts(errorMessage: String) {
        AlertCenter.show(title: "Error", message: errorMessage, buttonText: "Ok", viewController: self, completion: {
            if let navigationDelegate = self.navigationDelegate{
                navigationDelegate.closeApplication()
            }
        })
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.goToResetPin()
        }
    }
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.closeApplication()
        }
    }
}
