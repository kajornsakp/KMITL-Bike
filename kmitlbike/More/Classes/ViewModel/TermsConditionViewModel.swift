//
//  TermsConditionViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/5/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD
class TermsConditionViewModel: BaseViewModel {

    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var htmlString = ""{
        didSet{
            self.delegate?.onDataDidLoad()
        }
    }
    func getTermsCondition(){
        SVProgressHUD.show()
        provider.request(.getTermsCondition)
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    self.htmlString =  String(data: element.data, encoding: String.Encoding.utf8)!
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
        }
    }
    
}
