//
//  HomeViewModel.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewProtocol: class{
    func addressGenerated()
    func insertPIN(title: String)
    func showKey(key: String)
    func showError(errorMessage: String)
}

class HomeViewModel{
    
    weak private var output: HomeViewProtocol?
    
    init(output: HomeViewProtocol) {
        self.output = output
    }
    
    func walletHasPrivateKey() -> Bool{
        let walletManager = WalletManager()
        return walletManager.doesWalletHasGeneratedKey()
    }
    
    func createKeyAndAddress(){
        let walletManager = WalletManager()
        walletManager.createKeyAndAddress()
        output?.addressGenerated()
    }
    
    func recreateAddress(){
        let walletManager = WalletManager()
        walletManager.recreateAddress()
        output?.addressGenerated()
    }
    
    func requestingForShowingKey(){
        if walletHasPrivateKey(){
            output?.insertPIN(title: "Authentication")
        }else{
            output?.showError(errorMessage: "There is no private key. You should generate it first.")
        }
    }
    
    func authenticatePIN(pinCode: String){
        // NOTE: This should be done in model
        // validation
        if pinCode.characters.count != 6 {
            output?.showError(errorMessage: "PIN code must be 6 characters long")
            return
        }
        
        let userManager = UserManager()
        let userAuthenticated = userManager.checkIsCorrectPin(for: pinCode)
        
        if userAuthenticated.status == .success {
            let walletManager = WalletManager()
            let privateKey = walletManager.getPrivateKey()
            output?.showKey(key: privateKey)
        }else{
            output?.showError(errorMessage: "Incorrect PIN code.")
        }
    }
    
    func getAddress() -> String{
        let walletManager = WalletManager()
        let address = walletManager.getAddress()
        return (address.isEmpty) ? "--" : address
    }
}
