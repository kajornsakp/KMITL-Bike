//
//  SignupViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
class SignupViewModel: BaseViewModel {
    
    let provider = RxMoyaProvider<KmitlBikeService>()
    var loginResponse : LoginResponse!
    weak var signupDelegate : SignupDelegate!
    func signup(withUsername username : String,firstName : String,lastName : String,gender : Int,email : String , mobileNumber : String){
        if(!self.inputValidation(username: username,firstName: firstName,lastName: lastName,email: email,mobileNumber: mobileNumber)){
            return
        }
    }
    
    
    func inputValidation(username : String,firstName : String,lastName : String,email : String,mobileNumber : String)->Bool{
        if username.isEmpty {
            return false
        }
        if firstName.isEmpty{
            return false
        }
        if lastName.isEmpty{
            return false
        }
        if email.isEmpty{
            return false
        }
        if mobileNumber.isEmpty{
            return false
        }
        return true
    }
//    func login(withUsername username : String, withPassword password : String){
//        if username.isEmpty || password.isEmpty{
//            self.invalidInput()
//            return
//        }
//        SVProgressHUD.show()
//        let form = LoginForm()
//        form.username = username
//        form.password = password
//        provider.request(.login(form: form))
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//            .subscribe{ event in
//                print("event",event)
//                switch event{
//                case .next(let element):
//                    self.loginResponse = LoginResponse(withDictionary: element as AnyObject)
//                    self.checkLogin()
//                case .error(let error):
//                    self.showError(error: error as! Moya.Error)
//                default:
//                    break
//                }
//                
//        }
//        
//    }
//    
//    func checkLogin(){
//        if self.loginResponse.result == "first_time" {
//            self.loginDelegate.onFirstTimeLogin()
//        }
//        else if self.loginResponse.result == "success"{
//            self.loginDelegate.onLoginSuccess()
//        }
//    }
//    func invalidInput(){
//        self.loginDelegate.onLoginError(message: "Invalid input")
//    }
//    
//    func showError(error : Moya.Error){
//        if let errorResponse = error.response{
//            switch errorResponse.statusCode {
//            case 400:
//                self.loginDelegate.onLoginError(message: "Failed to connect with the server")
//            case 406:
//                self.loginDelegate.onLoginError(message: "Invalid Username / Password")
//            default:
//                self.loginDelegate.onLoginError(message: "Error")
//            }
//        }
//    }
}

