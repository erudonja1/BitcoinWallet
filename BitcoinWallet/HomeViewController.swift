//
//  ViewController.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {

    weak var navigationDelegate: MainNavigation?
    private var viewModel: HomeViewModel?
    
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var generateAddressButton: UIButton!
    
    @IBOutlet weak var walletKeyLabel: UILabel!
    @IBOutlet weak var showKeyButton: UIButton!
    
    @IBOutlet weak var recreateAddressLabel: UILabel!
    @IBOutlet weak var recreateAddressButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(output: self as HomeViewProtocol)
        
        if let walletHasPrivateKey = viewModel?.walletHasPrivateKey(){
            self.setupView(walletHasPrivateKey)
        }
        // "else" case should never happend. If it happends, then nothing will be set
        
    }

    func addressGenerated() {
        if let walletHasPrivateKey = viewModel?.walletHasPrivateKey(){
            self.setupView(walletHasPrivateKey)
        }
         AlertCenter.show(title: "Done", message: "New address has been set.", buttonText: "Ok", viewController: self)
    }
    
    func insertPIN(title: String) {
        AlertCenter.show(title: title, placeholder: "PIN code", buttonText: "Submit", viewController: self, completion: { pinCode in
            self.viewModel?.authenticatePIN(pinCode: pinCode)
        })
    }
    
    func showKey(key: String) {
        AlertCenter.show(title: "Private key", message: key, buttonText: "Ok", viewController: self)
    }
    
    func showError(errorMessage: String){
        AlertCenter.show(title: "Error", message: errorMessage, buttonText: "Ok", viewController: self)
    }
    
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        self.viewModel?.createKeyAndAddress()
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        self.viewModel?.requestingForShowingKey()
    }
    
    @IBAction func recreateButtonPressed(_ sender: UIButton) {
        self.viewModel?.recreateAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func setupView(_ walletHasPrivateKey: Bool){
        
        if (walletHasPrivateKey == true){
            
            walletAddressLabel.text = self.viewModel?.getAddress()
            generateAddressButton.isHidden = true
            
            walletKeyLabel.text = "**************"
            showKeyButton.titleLabel?.text = "Show"
            showKeyButton.isEnabled = true
            
            recreateAddressButton.titleLabel?.text = "Recreate >>"
            recreateAddressButton.isHidden = false
            recreateAddressLabel.text = "Do you want to recreate Wallet address based on the same key?"
            recreateAddressLabel.isHidden = false
            
        }else{
            //its first time probably
            walletAddressLabel.text = "--"
            generateAddressButton.titleLabel?.text = "Create"
            generateAddressButton.isHidden = false
            
            showKeyButton.isEnabled = false
            
            recreateAddressButton.isHidden = true
            recreateAddressLabel.isHidden = true
            
        }
    }
}

