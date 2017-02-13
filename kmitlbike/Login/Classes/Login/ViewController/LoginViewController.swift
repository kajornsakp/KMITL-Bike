//
//  LoginViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundButton!
    static let segueIdentifier = "goToHomePageSegue"
    var viewModel : LoginViewModel!
    
    @IBOutlet weak var bikeIconHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(delegate : self)
        viewModel.loginDelegate = self
        self.setTapGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        self.view.endEditing(true)
        self.loginButton.isEnabled = false
        if(Developer.ENABLED && Developer.BYPASS_LOGIN){
           viewModel.login(withUsername: "s7090006", withPassword: "Abcde016400")
        }
        else{
            viewModel.login(withUsername: usernameTextField.text!, withPassword: passwordTextField.text!)
        }
    }
    
    @IBAction func onSignupIAMKmitlCLick(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://iam.kmitl.ac.th/page_iamsystem.php")!)
    }
    
    
}


extension LoginViewController : LoginDelegate{
    func onLoginSuccess() {
        self.loginButton.isEnabled = true
        SVProgressHUD.dismiss()
        SVProgressHUD.showSuccess(withStatus: "Login Success")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: HomeViewController.TAB_BAR_CONTROLLER_IDENTIFIER)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func onFirstTimeLogin() {
        self.loginButton.isEnabled = true
        SVProgressHUD.dismiss()
        let vc = ViewControllerFactory.sharedInstance.resolve(service: SignUpViewController.self)
        vc.username = self.usernameTextField.text
        guard let navigationController = self.navigationController else{
            self.present(vc, animated: true, completion: nil)
            return
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onLoginError(message: String) {
        self.loginButton.isEnabled = true
        SVProgressHUD.dismiss()
        SVProgressHUD.showError(withStatus: message)
    }
}
