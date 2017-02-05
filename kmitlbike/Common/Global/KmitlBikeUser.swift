//
//  KmitlBikeUser.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/8/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

class UserSessionData : NSObject,NSCoding {
    var valid : Bool{
        get{
            return token != nil
        }
    }
    var username : String?
    var firstname : String?
    var lastname : String?
    var phoneNumber : String?
    var email : String?
    var token : String?
    var gender : NSNumber?
    
    override init(){
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        if let username = aDecoder.decodeObject(forKey: "username") as? String{
            self.username = username
        }
        if let firstname = aDecoder.decodeObject(forKey: "firstname") as? String{
            self.firstname = firstname
        }
        if let lastname = aDecoder.decodeObject(forKey: "lastname") as? String{
            self.lastname = lastname
        }
        if let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String{
            self.phoneNumber = phoneNumber
        }
        if let email = aDecoder.decodeObject(forKey: "email") as? String{
            self.email = email
        }
        if let token = aDecoder.decodeObject(forKey: "token") as? String{
            self.token = token
        }
        if let gender = aDecoder.decodeObject(forKey: "gender") as? NSNumber{
            self.gender = gender
        }
    }

    func encode(with aCoder: NSCoder) {
        if let username = self.username{
            aCoder.encode(username, forKey: "username")
        }
        if let firstname = self.firstname{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if let lastname = self.lastname{
            aCoder.encode(lastname, forKey: "lastname")
        }
        if let phoneNumber = self.phoneNumber{
            aCoder.encode(phoneNumber, forKey: "phoneNumber")
        }
        if let email = self.email{
            aCoder.encode(email, forKey: "email")
        }
        if let token = self.token{
            aCoder.encode(token, forKey: "token")
        }
        if let gender = self.gender{
            aCoder.encode(gender, forKey: "gender")
        }
    }
}

class UserSession : NSObject{
    let KEY_USER_SESSION_DATA = "UserSession.data"
    
    static let sharedInstance = UserSession()
    let userDefaults = UserDefaults.standard
    
    var data : UserSessionData{
        get{
            return restore()
        }
    }
    
    func storeToken(token : String?){
        let data = self.data
        data.token = token
        store(data: data)
    }
    
    func storeUser(user: User){
        let data = self.data
        data.firstname = user.firstname
        data.lastname = user.lastname
        data.phoneNumber = user.phoneNumber
        data.token = user.token
        data.email = user.email
        data.gender = user.gender
        store(data: data)
    }
    
    func storeUsername(username : String){
        let data = self.data
        data.username = username
        store(data: data)
    }
    
    func clearUserSession(){
        let data = self.data
        data.username = nil
        data.firstname = nil
        data.lastname = nil
        data.phoneNumber = nil
        data.email = nil
        data.token = nil
        data.gender = nil
        clear()
    }
    
    private func restore() -> UserSessionData{
        guard let decodedNSData = userDefaults.object(forKey: KEY_USER_SESSION_DATA) as? NSData,
            let userSession = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? UserSessionData else{
                return UserSessionData()
        }
        return userSession
    }
    
    private func store(data: UserSessionData){
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: data), forKey: KEY_USER_SESSION_DATA)
        userDefaults.synchronize()
    }
    private func clear(){
        userDefaults.removeObject(forKey: KEY_USER_SESSION_DATA)
        userDefaults.synchronize()
    }
}
