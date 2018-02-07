//
//  LoginViewModel.swift
//  BitcoinWallet
//
//  Created by mac on 07/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol: class{
    func loginSucceded()
    func loginFailed(errorMessage: String)
    func noMoreLoginAttempts(errorMessage: String)
}

class LoginViewModel{
    
    weak private var output: LoginViewProtocol?
    private var attemptCounter: Int = 0
    
    init(output: LoginViewProtocol) {
        self.output = output
    }
    
    func login(pinCode: String){
        let userManager = UserManager()
        let loginResult = userManager.checkIsCorrectPin(for: pinCode).status
        if loginResult == .success {
            self.succedeedAttempt()
        }else{
            self.missedAttempt()
        }
    }
    
    private func missedAttempt(){
        attemptCounter = attemptCounter + 1
        if (attemptCounter == 5){
            output?.noMoreLoginAttempts(errorMessage: "Too many PIN attempts. Please try again later.")
        }else{
            let leftAttempts = 5 - attemptCounter
            output?.loginFailed(errorMessage: "Wrong PIN code. Try again! \n (you have \(leftAttempts) more attempts)")
        }
    }
    
    private func succedeedAttempt(){
        output?.loginSucceded()
    }
    
}
