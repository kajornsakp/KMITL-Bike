//
//  SignUpViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import SVProgressHUD
import PopupDialog
class SignUpViewController: BaseViewController {

    var username : String!
    
    @IBOutlet weak var agreeTermButton: UIButton!
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
        viewModel.getTermsCondition()
        self.setTapGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackButtonClick(_ sender: Any) {
        guard let navigationController = self.navigationController else{
            self.dismiss(animated: true, completion: nil)
            return
        }
        let _ = navigationController.popViewController(animated: true)
    }
    
    @IBAction func onSignupButtonClick(_ sender: Any) {
        self.view.endEditing(true)
        let firstName = self.firstNameTextField.text!
        let lastName = self.lastNameTextField.text!
        let gender = self.genderSegmentedControl.selectedSegmentIndex+1
        let email = self.emailTextField.text!
        let mobileNumber = self.mobileNumberTextField.text!
        self.viewModel.signup(withUsername: self.username, firstName: firstName, lastName:lastName, gender: gender, email: email, mobileNumber: mobileNumber)
    }
    
    @IBAction func onAgreeTermConditionClick(_ sender: Any) {
        self.viewModel.agreeTerm = true
        self.agreeTermButton.setImage(#imageLiteral(resourceName: "kmitlbike_signup_check_button"), for: .normal)
        
    }
    @IBAction func onViewTermConditions(_ sender: Any) {
        let vc = ViewControllerFactory.sharedInstance.resolve(service: SignUpTermsConditionViewController.self)
        guard let navigationController = self.navigationController else{
            self.present(vc, animated: true, completion: nil)
            return
        }
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SignUpViewController : SignupDelegate{
    func onSignupSuccess() {
        SVProgressHUD.showSuccess(withStatus: "Register success!")
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func onSignupError(message: String) {
        let popup = PopupDialog(title: "Error", message: message)
        popup.transitionStyle = .fadeIn
        self.present(popup,animated: true,completion: nil)
    }
    func onInputError(message: String) {
        let popup = PopupDialog(title: "Error", message: message)
        popup.transitionStyle = .fadeIn
        self.present(popup,animated: true,completion: nil)
    }
}
