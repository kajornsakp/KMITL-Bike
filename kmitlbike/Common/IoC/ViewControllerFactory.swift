//
//  ViewControllerFactory.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Swinject

private struct Storyboard {
    static let login = "Login"
}

class ViewControllerFactory: BaseFactory
{
    static let sharedInstance = ViewControllerFactory()
    
    override init() {
        super.init()
    }
    
    internal override func setup() {
        loginViewController()
        signupViewController()
    }
    
    // MARK:
    // MARK: Organize methods in alphabetical order
    
    private func loginViewController(){
        container.register(LoginViewController.self){
            _ in
            let storyboard = UIStoryboard(name : Storyboard.login,bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
            return vc
        }
    }
    private func signupViewController(){
        container.register(SignUpViewController.self){
            _ in
            let storyboard = UIStoryboard(name : Storyboard.login,bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier : SignUpViewController.className) as! SignUpViewController
            return vc
        }
    }
}
