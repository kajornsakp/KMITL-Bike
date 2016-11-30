//
//  LoginResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


public class LoginResponse: BaseResponse {
    var firstName : String?
    var lastName : String?
    var email : String?
    var phoneNum : String?
    var token : String?
    var gender : Int?
    
    required public init(withDictionary dict : AnyObject) {
        super.init(withDictionary : dict)
        if let firstName = dict["first_name"] as? String{
            self.firstName = firstName
        }
        if let lastName = dict["last_name"] as? String{
            self.lastName = lastName
        }
        if let email = dict["email"] as? String{
            self.email = email
        }
        if let phoneNum = dict["phone_no"] as? String{
            self.phoneNum = phoneNum
        }
        if let token = dict["token"] as? String{
            self.token = token
        }
        if let gender = dict["gender"] as? Int{
            self.gender = gender
        }
    }
}
