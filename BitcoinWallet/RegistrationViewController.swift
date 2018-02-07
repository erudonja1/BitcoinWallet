//
//  RegistrationViewController.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationViewProtocol {
    
    weak var navigationDelegate: MainNavigation?
    private var viewModel: RegistrationViewModel?
    
    @IBOutlet weak var pinCodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RegistrationViewModel(output: self as RegistrationViewProtocol)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        // register it into the system
        self.viewModel?.register(pinCode: pinCodeTextField.text ?? "")
    }

    func registrationSucceded() {
        // tell the navigation Delegate that login succeded
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.registrationFinished()
        }
    }
    
    func registrationFailed(errorMessage: String) {
        AlertCenter.show(title: "Error", message: errorMessage, buttonText: "Ok", viewController: self)
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.closeApplication()
        }
    }
}
