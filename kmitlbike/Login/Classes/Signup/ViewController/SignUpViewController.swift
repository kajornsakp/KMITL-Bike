//
//  SignUpViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    var username : String! {
        didSet{
            print(username)
        }
    }
    
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
        
    }
    
}

extension SignUpViewController : SignupDelegate{
    func onSignupSuccess() {
        //
    }
    func onSignupError(message: String) {
        //
    }
    func onInputError(message: String) {
        //
    }
}
