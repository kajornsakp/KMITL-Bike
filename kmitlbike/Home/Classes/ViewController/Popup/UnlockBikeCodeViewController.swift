//
//  UnlockBikeCodeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class UnlockBikeCodeViewController: BaseViewController {

    @IBOutlet weak var passcodeLabel: UILabel!
    var passcode : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let passcode = self.passcode else{
            return
        }
        self.passcodeLabel.text = passcode
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
