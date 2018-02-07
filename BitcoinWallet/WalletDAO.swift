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
    
    func readKey() -> String {
        let privateKey = UserDefaults.standard.string(forKey: WalletDAO.nameForPrivateKey)
        return privateKey ?? ""
    }
    
    func readAddress() -> String{
        let privateAddress = UserDefaults.standard.string(forKey: WalletDAO.nameForAddress)
        return privateAddress ?? ""
    }
    
    func saveKey(key: String){
         UserDefaults.standard.set(key, forKey: WalletDAO.nameForPrivateKey)
        
    }
    
    func saveAddress(address: String){
         UserDefaults.standard.set(address, forKey: WalletDAO.nameForAddress)
    }
    
    
}
