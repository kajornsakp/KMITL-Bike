//
//  SignUpViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import SVProgressHUD
class SignUpViewController: BaseViewController {

    var username : String!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    var viewModel : SignupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignupViewModel(delegate : self)
        viewModel.signupDelegate = self
        self.setTapGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSignupButtonClick(_ sender: Any) {
        let firstName = self.firstNameTextField.text!
        let lastName = self.lastNameTextField.text!
        let gender = self.genderSegmentedControl.selectedSegmentIndex+1
        let email = self.emailTextField.text!
        let mobileNumber = self.mobileNumberTextField.text!
        self.viewModel.signup(withUsername: self.username, firstName: firstName, lastName:lastName, gender: gender, email: email, mobileNumber: mobileNumber)
    }
    
}

extension SignUpViewController : SignupDelegate{
    func onSignupSuccess() {
        SVProgressHUD.showSuccess(withStatus: "Register success!")
        self.navigationController?.popViewController(animated: true)
    }
    func onSignupError(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    func onInputError(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
