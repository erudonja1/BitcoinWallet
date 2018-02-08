//
//  KeyGenerator.swift
//  BitcoinWallet
//
//  Created by mac on 08/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation
class KeyGenerator {
    
    class func randomHexDigit() -> Character {
        let hex: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        let randomInt = Int(arc4random_uniform(16))
        return hex[randomInt]
    }
    
    class func newPrivateKey() -> [Character] {
        var key: [Character] = []
        for _ in 1...64 {
            key.append(randomHexDigit())
        }
        return key
    }
}
