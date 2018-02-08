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
        
        let appHex = initApplicationHex()
        walletDAO.saveAppKey(key: appHex)
        
        let privateKey = generatePrivateKey(with: appHex)
        walletDAO.saveKey(key: privateKey)
        
        let publicAddress = generatePublicAddress(with: appHex, counter: 0)
        walletDAO.saveAddress(address: publicAddress, counter: 0)
    }
    
    func recreateAddress(){
        let walletDAO = WalletDAO()
        let appHex = walletDAO.readAppKey()
        var counter = walletDAO.readCounter()
        counter = counter + 1
        
        let publicAddress = generatePublicAddress(with: appHex, counter: counter)
        walletDAO.saveAddress(address: publicAddress, counter: counter)
    }
    
    func getPrivateKey() -> String{
        let walletDAO = WalletDAO()
        return walletDAO.readKey()
    }
    
    func getAddress() -> String{
        let walletDAO = WalletDAO()
        return walletDAO.readAddress()
    }
    
    
    // VERY IMPORTANT: this should be generated only once and it is saved in application, not visible to user
    private func initApplicationHex() -> String{
        let masterHex = WalletService.getMasterHex()
        return masterHex
    }
    
    // this private key would be shown to user
    private func generatePrivateKey(with masterHex: String) -> String{
        let extendPrivKey = WalletService.getExtendPrivKey(masterHex, accountIdx:0)
        let mainPrivKey = WalletService.getPrivateKey(extendPrivKey as NSString)
        return mainPrivKey
    }
    
    //this address will be shown to user
    private func generatePublicAddress(with masterHex: String, counter: Int) -> String{
        // Not recommended!
        // We can call something like
        // let extendPubKey = WalletService.getExtendPubKeyFromMasterHex(masterHex, accountIdx:0)
        
        let extendPrivKey = WalletService.getExtendPrivKey(masterHex, accountIdx:0)
        let extendPubKey = WalletService.getExtendPubKey(extendPrivKey)
        let mainAddress = WalletService.getAddress(extendPubKey, counter: counter)
        return mainAddress
    }
}
