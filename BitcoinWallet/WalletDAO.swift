//
//  WalletService.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation


class WalletDAO: NSObject{
    private static let nameForAddress = "privateAddress"
    private static let nameForPrivateKey = "privateKey"
    private static let nameForAppKey = "applicationKey"
    private static let nameForCounter = "counterGeneration"
    
    // HEX KEY of application
    func readAppKey() -> String{
        let key = UserDefaults.standard.string(forKey: WalletDAO.nameForAppKey)
        return key ?? ""
    }
    func saveAppKey(key: String){
         UserDefaults.standard.set(key, forKey: WalletDAO.nameForAppKey)
    }
    
    // PRIVATE KEY of BTCKeychain
    func readKey() -> String {
        let privateKey = UserDefaults.standard.string(forKey: WalletDAO.nameForPrivateKey)
        return privateKey ?? ""
    }
    func saveKey(key: String){
        UserDefaults.standard.set(key, forKey: WalletDAO.nameForPrivateKey)
    }
    
    // ADDRESS of BTCKeychain
    func readAddress() -> String{
        let privateAddress = UserDefaults.standard.string(forKey: WalletDAO.nameForAddress)
        return privateAddress ?? ""
    }
    func saveAddress(address: String, counter: Int){
        UserDefaults.standard.set(address, forKey: WalletDAO.nameForAddress)
        UserDefaults.standard.set(counter, forKey: WalletDAO.nameForCounter)
    }
    
    // Counter of generate address attempts
    func readCounter() -> Int{
        let key = UserDefaults.standard.integer(forKey: WalletDAO.nameForCounter)
        return key
    }
}
