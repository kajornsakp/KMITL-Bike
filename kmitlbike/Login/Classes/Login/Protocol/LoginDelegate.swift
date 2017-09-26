//
//  LoginDelegate.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/17/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

protocol LoginDelegate : class{
    func onLoginSuccess()
    func onFirstTimeLogin()
    func onLoginError(message : String)
}
