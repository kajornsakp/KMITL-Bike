//
//  LaunchScreenViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/5/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class LaunchScreenViewController: BaseViewController {

    var viewModel : LaunchScreenViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LaunchScreenViewModel(delegate: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.checkUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onDataDidLoad() {
        if(checkUserLogin()){
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: HomeViewController.TAB_BAR_CONTROLLER_IDENTIFIER)
            UIApplication.shared.keyWindow?.rootViewController = vc
            
        }
        else{
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
            
        }
    }
    
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        let vc = ViewControllerFactory.sharedInstance.resolve(service: UpdateViewController.self)
        vc.updateUrl = errorMessage
        vc.lastestVersion = self.viewModel.checkUpdateResponse.criticalVersion!
        self.present(vc, animated: true, completion: nil)
    }
    func checkUserLogin()->Bool{
        let user = UserSession.sharedInstance.data
        return user.valid
    }
}
