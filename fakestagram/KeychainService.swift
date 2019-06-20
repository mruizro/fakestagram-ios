//
//  KeychainService.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles on 6/19/19.
//  Copyright © 2019 ruizro. All rights reserved.
//

import Foundation
import Security

let userAccount = "AuthenticatedUser"
let accessGroup = "SecuritySerivice"


let passwordKey = "iosdevlab"

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class KeychainService:NSObject{
    
    
    
    class func setValue(value: String, forService: String, account:String ) {
        
        if let dataFromString = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, forService, account, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if (status != errSecSuccess) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Failed setting: \(err)")
                }
            }
        }
    }
    
    class func getValue(forService: String, account:String) -> String? {

        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, forService, account, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
}
    




