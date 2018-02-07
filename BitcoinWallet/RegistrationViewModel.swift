//
//  RegistrationViewModel.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import UIKit

protocol RegistrationViewProtocol: class{
    func registrationSucceded()
    func registrationFailed(errorMessage: String)
}

class RegistrationViewModel{
    
    weak private var output: RegistrationViewProtocol?
    
    init(output: RegistrationViewProtocol) {
        self.output = output
    }
    
    func register(pinCode: String){
        let userManager = UserManager()
        if (pinCode.characters.count != 6) {
            self.failedValidation()
            return
        }
        if (pinCode.isEmpty) {
            self.failedAttempt()
        }else{
            userManager.setPin(newPinCode: pinCode)
            self.succedeedAttempt()
        }
    }
    
    private func succedeedAttempt(){
        output?.registrationSucceded()
    }
    
    private func failedAttempt(){
        output?.registrationFailed(errorMessage: "Incorrect value was set.")
    }
    private func failedValidation(){
        output?.registrationFailed(errorMessage: "PIN code must be 6 digits size.")
    }
    
}
