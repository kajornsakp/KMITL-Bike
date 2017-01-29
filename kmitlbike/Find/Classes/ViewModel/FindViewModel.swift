//
//  FindViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/14/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD
class FindViewModel: BaseViewModel {

    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var bikeList = [BikeModel]()
    var bikeModelResponse : BikeModelResponse!{
        didSet{
            self.bikeList = bikeModelResponse.bikeList!
            self.delegate!.onDataDidLoad()
        }
    }
    func getAvailableBike(){
        SVProgressHUD.show()
        provider.request(.getAvailableBike)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    self.bikeModelResponse = BikeModelResponse(withDictionary: element as AnyObject)
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
                
        }

    }
    
}
