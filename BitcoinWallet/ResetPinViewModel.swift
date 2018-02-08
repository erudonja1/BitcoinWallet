//
//  ResetPinViewModel.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

protocol ResetPinViewProtocol: class{
    func resetSucceded()
    func resetFailed(errorMessage: String)
}

class ResetPinViewModel {
    weak private var output: ResetPinViewProtocol?
    
    init(output: ResetPinViewProtocol) {
        self.output = output
    }
    
    func resetPin(newValue: String, oldValue: String){
        let userManager = UserManager()
        //validation
        if (newValue.characters.count != 6) {
            self.failedValidation()
            return
        }
        //validation
        if (newValue.isEmpty) {
            self.failedAttempt()
            return
        }
        
        if userManager.checkIsCorrectPin(for: oldValue).status == .success{
            userManager.setPin(newPinCode: newValue)
            self.succedeedAttempt()
        }else{
            self.failedAttempt()
        }
        
    }
    
    
    private func succedeedAttempt(){
        output?.resetSucceded()
    }
    
    private func failedAttempt(){
        output?.resetFailed(errorMessage: "Incorrect value for current PIN was set.")
    }
    
    private func failedValidation(){
        output?.resetFailed(errorMessage: "PIN code must be 6 digits size.")
    }
}
