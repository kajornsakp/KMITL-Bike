//
//  SignUpTermsConditionViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/7/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD

class SignUpTermsConditionViewController: BaseViewController {

    @IBOutlet weak var webView : UIWebView!
    var provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var htmlString : String = ""{
        didSet{
            self.webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTermsCondition()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getTermsCondition(){
        let _ = provider.request(.getTermsCondition)
            .filterSuccessfulStatusCodes()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    self.htmlString =  String(data: element.data, encoding: String.Encoding.utf8)!
                case .error(let _):
                    SVProgressHUD.showError(withStatus: "Failed to load Terms and Conditions")
                default:
                    break
                }
        }
    }
    
    @IBAction func onCloseButtonClick(_ sender: Any) {
        guard let navigationController = self.navigationController else{
            self.dismiss(animated: true, completion: nil)
            return
        }
        let _ = navigationController.popViewController(animated: true)
    }
    
}
