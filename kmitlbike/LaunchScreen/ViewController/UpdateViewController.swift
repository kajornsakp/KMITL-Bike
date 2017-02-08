//
//  UpdateViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/6/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class UpdateViewController: BaseViewController {
    var lastestVersion = ""
    var updateUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpdateClick(_ sender: Any) {
        if AppConfig.getApplicationVersion() == lastestVersion {
            self.dismiss(animated: true, completion: nil)
        }else{
            if let url = NSURL(string: self.updateUrl) {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
}
