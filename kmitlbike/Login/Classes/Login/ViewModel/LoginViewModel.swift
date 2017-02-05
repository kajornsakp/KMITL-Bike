//
//  LoginViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
class LoginViewModel: BaseViewModel {
    
    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var loginResponse : LoginResponse!
    weak var loginDelegate : LoginDelegate!
    var username : String!
    func login(withUsername username : String, withPassword password : String){
        if username.isEmpty || password.isEmpty{
            self.invalidInput()
            return
        }
        SVProgressHUD.show()
        self.username = username
        let form = LoginForm()
        form.username = username
        form.password = password
        let _ = provider.request(.login(form: form))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    self.loginResponse = LoginResponse(withDictionary: element as AnyObject)
                    self.checkLogin()
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
                
            }
        
        }
    
    func checkLogin(){
        if self.loginResponse.result == "first_time" {
            self.loginDelegate.onFirstTimeLogin()
        }
        else if self.loginResponse.result == "success"{
            guard let user = self.loginResponse.user else{
                self.loginDelegate.onLoginError(message: "Cannot login to system, please try again later.")
                return
            }
            UserSession.sharedInstance.storeUser(user: user)
            UserSession.sharedInstance.storeUsername(username: self.username)
            UserSession.sharedInstance.storeToken(token: user.token)
            self.loginDelegate.onLoginSuccess()
        }
    }
    func invalidInput(){
        self.loginDelegate.onLoginError(message: "Invalid input")
    }
    
    override func showError(error : Moya.Error){
        guard let errorResponse = error.response else{
            self.loginDelegate.onLoginError(message: "Error")
            return
        }
        switch errorResponse.statusCode {
            case 400:
                self.loginDelegate.onLoginError(message: "Failed to connect with the server")
            case 406:
                self.loginDelegate.onLoginError(message: "Invalid Username / Password")
            default:
                self.loginDelegate.onLoginError(message: "Error")
        }
        
        
    }
}

