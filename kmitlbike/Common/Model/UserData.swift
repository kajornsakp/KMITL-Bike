//
//  UserData.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/17/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

public class UserData : NSObject{
    
    public static var sharedInstance = UserData()
    
    public var firstName : String?
    public var lastName : String?
    public var email : String?
    public var phoneNum : String?
    public var token : String?
    public var gender : Int?
    
    
}
