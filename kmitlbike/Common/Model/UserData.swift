//
//  UserData.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/17/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

class User : NSObject{
    
    var username : String?
    var firstname : String?
    var lastname : String?
    var phoneNumber : String?
    var email : String?
    var token : String?
    var gender : NSNumber?
    
    required init(withDictionary dict: AnyObject) {
        self.firstname = dict["first_name"] as? String
        self.lastname = dict["last_name"] as? String
        self.gender = dict["gender"] as? NSNumber
        self.phoneNumber = dict["phone_no"] as? String
        self.email = dict["email"] as? String
        self.token = dict["token"] as? String
    }
}
