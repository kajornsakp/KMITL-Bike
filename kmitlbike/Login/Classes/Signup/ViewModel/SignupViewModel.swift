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
    
    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var loginResponse : LoginResponse!
    weak var signupDelegate : SignupDelegate!
    func signup(withUsername username : String,firstName : String,lastName : String,gender : Int,email : String , mobileNumber : String){
        if(!self.inputValidation(username: username,firstName: firstName,lastName: lastName,email: email,mobileNumber: mobileNumber)){
            return
        }
        let form = SignupForm()
        form.username = username
        form.firstName = firstName
        form.lastName = lastName
        form.gender = gender
        form.email = email
        form.mobileNumber = mobileNumber
        provider.request(.signup(form: form))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    print(element)
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
                
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

    func showError(error : Moya.Error){
        SVProgressHUD.dismiss()
        print(error)
    }
}

