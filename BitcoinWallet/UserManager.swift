//
//  UserManager.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation


class UserManager{
    
    func userNotRegistered() -> Bool{
        let userDAO: UserDAO = UserDAO()
        return userDAO.readPin().isEmpty
    }
    
    func setPin(newPinCode: String){
        let userDAO: UserDAO = UserDAO()
        userDAO.save(pinCode: newPinCode)
    }
    
    func resetPin(newPinCode: String, existingPinCode: String) -> OperationResult{
        let userDAO: UserDAO = UserDAO()
        if (userDAO.readPin() == existingPinCode){
            self.setPin(newPinCode: newPinCode)
            return OperationResult(.success)
        }else{
            return OperationResult(.failed, message: "Wrong existing pin code inserted.")
        }
    }
    
    
    func checkIsCorrectPin(for pinCode: String) -> OperationResult{
        let userDAO: UserDAO = UserDAO()
        if (userDAO.readPin() == pinCode) {
            return OperationResult(.success)
        }else{
            return OperationResult(.failed)
        }
    }
    
    
}
