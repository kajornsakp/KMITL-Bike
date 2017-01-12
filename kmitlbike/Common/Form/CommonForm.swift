//
//  LoginForm.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


class LoginForm{
    var username : String = ""
    var password : String = ""
    
    func toDict() -> [String : AnyObject] {
        var dict = [String: AnyObject]()
        dict["username"] = username as AnyObject?
        dict["password"] = password as AnyObject?
        return dict
    }
}

class SignupForm{
    var username : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var gender : Int = 0
    var email : String = ""
    var mobileNumber : String = ""
    
    func toDict() -> [String : AnyObject] {
        var dict = [String: AnyObject]()
        dict["username"] = username as AnyObject?
        dict["first_name"] = firstName as AnyObject?
        dict["last_name"] = lastName as AnyObject?
        dict["gender"] = gender as AnyObject?
        dict["email"] = email as AnyObject?
        dict["phone_no"] = mobileNumber as AnyObject?
        
        return dict
    }
    
}


