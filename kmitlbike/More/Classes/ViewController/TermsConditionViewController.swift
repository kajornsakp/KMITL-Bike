//
//  TermsConditionViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/5/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class TermsConditionViewController: BaseViewController {

    @IBOutlet weak var webView : UIWebView!
    var htmlString : String = ""
    var viewModel : TermsConditionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TermsConditionViewModel(delegate: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.loadHTMLString(self.htmlString, baseURL: nil)
        viewModel.getTermsCondition()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onDataDidLoad() {
        webView.loadHTMLString(self.viewModel.htmlString, baseURL: nil)
    }


}
