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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(delegate : self)
        viewModel.loginDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        if(Developer.ENABLED && Developer.BYPASS_LOGIN){
            viewModel.login(withUsername: "s7090006", withPassword: "Abcde016400")
        }
        else{
            viewModel.login(withUsername: usernameTextField.text!, withPassword: passwordTextField.text!)
        }
    }
    
}


extension LoginViewController : LoginDelegate{
    func onLoginSuccess() {
        SVProgressHUD.dismiss()
        SVProgressHUD.showSuccess(withStatus: "Login Success")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: HomeViewController.TAB_BAR_CONTROLLER_IDENTIFIER)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func onFirstTimeLogin() {
        SVProgressHUD.dismiss()
        let vc = ViewControllerFactory.sharedInstance.resolve(service: SignUpViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onLoginError(message: String) {
        SVProgressHUD.dismiss()
        SVProgressHUD.showError(withStatus: message)
    }
}
