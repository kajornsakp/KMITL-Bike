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
    
    let provider = RxMoyaProvider<KmitlBikeService>()
    var loginResponse : LoginResponse!
    weak var loginDelegate : LoginDelegate!
    func login(withUsername username : String, withPassword password : String){
        if username.isEmpty || password.isEmpty{
            self.invalidInput()
            return
        }
        SVProgressHUD.show()
        let form = LoginForm()
        form.username = username
        form.password = password
        provider.request(.login(form: form))
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
                    break
                }
                
            }
        
        }
    
    func checkLogin(){
        if self.loginResponse.result == "first_time" {
            self.loginDelegate.onFirstTimeLogin()
        }
        else if self.loginResponse.result == "success"{
            self.loginDelegate.onLoginSuccess()
        }
    }
    func invalidInput(){
        self.loginDelegate.onLoginError(message: "Invalid input")
    }
    
    func showError(error : Moya.Error){
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

