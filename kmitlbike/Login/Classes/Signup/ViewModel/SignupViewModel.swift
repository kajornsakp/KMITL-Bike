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
    var agreeTerm :Bool = false
    var htmlString : String = ""
    var signupResponse : BaseResponse!{
        didSet{
            self.checkResponse()
        }
    }
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
        SVProgressHUD.show()
        let _ = provider.request(.signup(form: form))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    let response = BaseResponse(withDictionary: element as AnyObject)
                    self.signupResponse = response
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
                
        }

    }
    
    func checkResponse(){
        switch self.signupResponse.result! {
        case "success":
            self.signupDelegate.onSignupSuccess()
        default:
            self.signupDelegate.onSignupError(message: "Failed to register.Please try again")
        }
    }
    func inputValidation(username : String,firstName : String,lastName : String,email : String,mobileNumber : String)->Bool{
        if !self.agreeTerm{
            self.signupDelegate.onSignupError(message: "You must agree to our Terms and Conditions before using the service")
            return false
        }
        if username.isEmpty {
            return false
        }
        if firstName.isEmpty{
            self.signupDelegate.onSignupError(message: "First name is required for register")
            return false
        }
        if lastName.isEmpty{
            self.signupDelegate.onSignupError(message: "Last name is required for register")
            return false
        }
        if email.isEmpty || !email.isValidEmail(){
            self.signupDelegate.onSignupError(message: "Email is required for register")
            return false
        }
        if mobileNumber.isEmpty || mobileNumber.characters.count != 10{
            self.signupDelegate.onSignupError(message: "Mobile number is required for register")
            return false
        }
        return true
    }
    
    func getTermsCondition(){
        SVProgressHUD.show()
        let _ = provider.request(.getTermsCondition)
            .filterSuccessfulStatusCodes()
            .subscribe{ event in

                switch event{
                case .next(let element):
                    self.htmlString =  String(data: element.data, encoding: String.Encoding.utf8)!
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }

            
        
    }
        
        
}
    override func showError(error : Moya.Error){
        guard let errorResponse = error.response else{
            self.signupDelegate.onSignupError(message: "Error")
            return
        }
        switch errorResponse.statusCode {
        case 400:
            self.signupDelegate.onSignupError(message: "Failed to connect with the server")
        case 406:
            self.signupDelegate.onSignupError(message: "Invalid username/password. Your username/password is either incorrect or it is not KMITL Gen. 2 account")
        default:
            self.signupDelegate.onSignupError(message: "Error")
        }
        
    }
}

