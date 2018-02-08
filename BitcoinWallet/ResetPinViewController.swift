//
//  ResetPinViewController.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit


class ResetPinViewController: UIViewController, ResetPinViewProtocol{
    
    weak var navigationDelegate: MainNavigation?
    private var viewModel: ResetPinViewModel?
    
    @IBOutlet weak var oldPinCodeTextField: UITextField!
    
    @IBOutlet weak var newPinCodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ResetPinViewModel(output: self as ResetPinViewProtocol)
    }
    
    
    @IBAction func resetPinButtonPressed(_ sender: UIButton) {
        let newValue = newPinCodeTextField.text ?? ""
        let oldValue = oldPinCodeTextField.text ?? ""
        viewModel?.resetPin(newValue: newValue, oldValue: oldValue)
    }
    
    func resetSucceded(){
        // tell the navigation Delegate that reset succeded
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.resetFinished()
        }
        AlertCenter.show(title: "Done", message: "New password has been set.", buttonText: "Ok", viewController: self)
    }
    func resetFailed(errorMessage: String){
        AlertCenter.show(title: "Error", message: errorMessage, buttonText: "Ok", viewController: self)
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        if let navigationDelegate = navigationDelegate{
            navigationDelegate.closeApplication()
        }
    }
}
