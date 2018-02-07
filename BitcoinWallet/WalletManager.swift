//
//  WalletManager.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation

class WalletManager{
    
    
    func doesWalletHasGeneratedKey() -> Bool{
        let walletDAO = WalletDAO()
        let isKeyEmpty = walletDAO.readKey().isEmpty
        return !(isKeyEmpty)
    }
    
    func createKeyAndAddress(){
        let walletDAO = WalletDAO()
        
        
        
    }
    
    func recreateAddress(){
        let walletDAO = WalletDAO()
        
        
    }
    
    func getPrivateKey() -> String{
        let walletDAO = WalletDAO()
        return walletDAO.readKey()
    }
    
}
