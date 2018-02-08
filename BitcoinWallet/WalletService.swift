//
//  WalletWrappper.swift
//  BitcoinWallet
//
//  Created by mac on 08/02/2018.
//  Copyright © 2018 Up and running software. All rights reserved.
//

import Foundation

class WalletService {
    
    class func getBIP44KeyChain(_ masterHex:NSString, accountIdx:UInt) -> BTCKeychain{
        let seed = BTCDataWithHexCString(masterHex.utf8String)
        let masterChain = BTCKeychain(seed:seed)
        let purposeKeychain = masterChain?.derivedKeychain(at: 44, hardened:true)
        let coinTypeKeychain = purposeKeychain?.derivedKeychain(at: 0, hardened:true)
        let accountKeychain = coinTypeKeychain?.derivedKeychain(at: UInt32(accountIdx), hardened:true)
        return accountKeychain!
    }
    
    class func getMasterHex() -> String {
        let key = KeyGenerator.newPrivateKey()
        let derivedKeyLen:Int = key.count
        let unsafeMutablePointerOfKey: UnsafeMutablePointer<Character> = UnsafeMutablePointer(mutating: key)
        let len = MemoryLayout<Character>.size * Int(derivedKeyLen)
        let masterSeedData = Data(bytes: UnsafePointer<Character>(unsafeMutablePointerOfKey), count: len)
        return (masterSeedData as NSData).hex()
    }
    
    // PRIVATE KEY
    class func getExtendPrivKey(_ masterHex:String, accountIdx:UInt) -> String{
        let accountKeychain = getBIP44KeyChain(masterHex as NSString, accountIdx:accountIdx)
        return accountKeychain.extendedPrivateKey
    }
    class func getPrivateKey(_ extendPrivKey:NSString) -> String{
        var keyChain = BTCKeychain(extendedKey:extendPrivKey as String)
        
        keyChain = keyChain?.derivedKeychain(at: UInt32(0), hardened:false)
        keyChain?.key.isPublicKeyCompressed = true
        return keyChain!.key.wif
    }
    
    // ADDRESS
    class func getAddress(_ extendPubKey:String, counter: Int) -> String{
        var publicKeyChain = BTCKeychain(extendedKey:extendPubKey)
        for idx in [0, counter] {
            publicKeyChain = publicKeyChain?.derivedKeychain(at: UInt32(idx), hardened:false)
        }
    //  publicKeyChain = publicKeyChain?.derivedKeychain(at: UInt32(0), hardened:false)
        return publicKeyChain!.key.address.string
    }
    
    class func getExtendPubKey(_ extendPrivKey:String) -> String{
        let privateKeyChain = BTCKeychain(extendedKey:extendPrivKey)
        return privateKeyChain!.extendedPublicKey
    }
    // NOTE: we can use this method too. Not used currently
//    class func getExtendPubKeyFromMasterHex(_ masterHex:String, accountIdx:UInt) -> String{
//        let accountKeychain = getBIP44KeyChain(masterHex as NSString, accountIdx:accountIdx)
//        return accountKeychain.extendedPublicKey
//    }
    
}
