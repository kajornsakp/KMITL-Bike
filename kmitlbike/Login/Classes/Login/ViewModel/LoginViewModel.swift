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
    var loginDelegate : LoginDelegate!
    func login(withUsername username : String, withPassword password : String){
        if username.isEmpty || password.isEmpty{
            self.invalidInput()
            return
        }
        SVProgressHUD.show()
        provider.request(.login(username: username, password: password))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .showErrorHUD()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    self.loginResponse = LoginResponse(withDictionary: element as AnyObject)
                    self.checkLogin()
                case .error(let error):
                    print("error")
                default:
                    break
                }
                
            }
        
        }
    
    func checkLogin(){
        if self.loginResponse.result == "first_time" {
            SVProgressHUD.dismiss()
            self.loginDelegate.onFirstTimeLogin()
        }
        else if self.loginResponse.result == "success"{
            SVProgressHUD.showSuccess(withStatus: "Login Success")
            self.loginDelegate.onLoginSuccess()
        }
    }
    func invalidInput(){
        SVProgressHUD.showError(withStatus: "Invalid input")
    }
}

extension Observable {
    func showErrorHUD() -> Observable<Element> {
        return self.doOn { event in
            switch event {
            case .error(let e):
                // Unwrap underlying error
                guard let error = e as? Moya.Error else { throw e }
                guard case .statusCode(let response) = error else { throw e }
                
                // Check statusCode and handle desired errors
                if response.statusCode == 400 {
                    SVProgressHUD.showError(withStatus: "Failed to connect the server")
                    
                } else if response.statusCode == 406 {
                    SVProgressHUD.showError(withStatus: "Invalid username / password")
                }
                
            default: break
            }
        }
    }
}
