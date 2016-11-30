//
//  LoginViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
class LoginViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: RoundButton!
    
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
        viewModel.login(withUsername: usernameTextField.text!, withPassword: passwordTextField.text!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension LoginViewController : LoginDelegate{
    func onLoginSuccess() {
        //
    }
    
    func onFirstTimeLogin() {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? SignUpViewController else{
            print("storyboard not found")
            return
        }
        vc.username = "s7090002"
        self.present(vc, animated: true, completion: nil)
    }
}
