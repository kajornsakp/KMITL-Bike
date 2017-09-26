//
//  LoginResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


public class LoginResponse: BaseResponse {
    var user : User?
    
    required public init(withDictionary dict : AnyObject) {
        super.init(withDictionary : dict)
        self.user = User(withDictionary: dict)
    }
}
