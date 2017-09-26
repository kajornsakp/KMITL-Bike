//
//  LaunchScreenViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/5/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD
class LaunchScreenViewModel: BaseViewModel {
    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var checkUpdateResponse : CheckUpdateResponse!
    func checkUpdate(){
        let version = AppConfig.getApplicationVersion()
        provider.request(.checkUpdate(version: version))
            .mapJSON()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    self.checkUpdateResponse = CheckUpdateResponse(withDictionary: element as AnyObject)
                    self.checkRequireUpdate()
                case .error(let error):
                    print(error)
                default:
                    break
                }
                
        }
    }
    
    func checkRequireUpdate(){
        if(self.checkUpdateResponse.requireUpdate)!{
            self.delegate?.onDataDidLoadErrorWithMessage(errorMessage: self.checkUpdateResponse.updateUrl!)
        }else{
            self.delegate?.onDataDidLoad()
        }
    }
    
}
