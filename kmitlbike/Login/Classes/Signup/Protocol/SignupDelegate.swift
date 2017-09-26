//
//  SignupDelegate.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

protocol SignupDelegate : class {
    func onSignupSuccess()
    func onSignupError(message : String)
    func onInputError(message : String)
}
