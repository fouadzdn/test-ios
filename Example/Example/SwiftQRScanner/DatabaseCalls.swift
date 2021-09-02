//
//  DatabaseCalls.swift
//  IOS12TabBarControllerTutorial
//
//  Created by IOS Developer 3 on 8/28/19.
//  Copyright © 2019 fouad zeidan. All rights reserved.
//

import UIKit
import RNCryptor

public class DatabaseCalls: NSObject {

    @objc static func GetDataFromLocal(WordId:String) -> Any
    {
        let password = "Secret password"
        let decoded  = UserDefaults.standard.data(forKey: WordId)
        
        // Decryption
        do {
            let originalData = try RNCryptor.decrypt(data: UserDefaults.standard.data(forKey: WordId) ?? Data(), withPassword: password)
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: originalData ?? Data())
            return  decodedTeams
        } catch {
            print(error)
        }
        
        return NSMutableArray()
        
//        let decoded  = UserDefaults.standard.data(forKey: WordId)
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded ?? Data()) as? NSMutableArray ?? NSMutableArray()
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: originalData ?? Data()) as? NSMutableArray ?? NSMutableArray()
//        return  decodedTeams
    }
    
    @objc static func SaveDataToLocal(WordId:String,DataArray:Any)
    {

        let password = "Secret password"
        let ciphertext = RNCryptor.encrypt(data: NSKeyedArchiver.archivedData(withRootObject: DataArray), withPassword: password)
        
        
        UserDefaults.standard.set(ciphertext, forKey: WordId)
        UserDefaults.standard.synchronize()
        
    }
    
    @objc static func ClearDatabase()
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
}
