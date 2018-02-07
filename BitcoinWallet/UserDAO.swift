//
//  UserService.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//
import Foundation
import UIKit

class UserDAO: NSObject{
    
    private static let keyForPin = "pinCode"
    
    func readPin() -> String{
        let activePinCode = UserDefaults.standard.string(forKey: UserDAO.keyForPin)
        return activePinCode ?? ""
    }
    
    func save(pinCode: String){
        UserDefaults.standard.set(pinCode, forKey: UserDAO.keyForPin)
    }
    
    

}


