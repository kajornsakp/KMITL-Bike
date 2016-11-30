//
//  BaseViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import MBProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension BaseViewController : BaseViewModelDelegate{
    
    public func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = .indeterminate
    }
    
    public func showLoading(withText text: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = .indeterminate
        loadingNotification.label.text = text
    }
    
    public func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    public func onDataDidLoad() {
        
    }
    
    public func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }
}
