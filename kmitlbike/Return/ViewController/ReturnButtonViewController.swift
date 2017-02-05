//
//  ReturnButtonViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import SVProgressHUD

class ReturnButtonViewController: BaseViewController {
    static let DISMISS_NOTIFICATION_KEY = "com.kajornsak.dismissnotification"
    var viewModel : ReturnButtonViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReturnButtonViewModel(delegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickReturnBike(_ sender: Any) {
        viewModel.returnBike()
    }

    override func onDataDidLoad() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "com.kajornsak.notificationkey"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: ReturnButtonViewController.DISMISS_NOTIFICATION_KEY), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }
}
