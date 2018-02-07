//
//  OperationResult.swift
//  BitcoinWallet
//
//  Created by mac on 06/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation

enum OperationResultType{
    case success
    case failed
}

class OperationResult: NSObject{
    
    let status: OperationResultType
    let message: String
    
    init(_ status: OperationResultType, message: String? = nil) {
        self.status = status
        self.message = message ?? ""
    }
}
