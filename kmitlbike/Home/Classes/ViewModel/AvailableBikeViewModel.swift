//
//  AvailableBikeViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/22/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD
class AvailableBikeViewModel: BaseViewModel {

    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var bikeList = [BikeModel]()
    var bikeModelResponse : BikeModelResponse!{
        didSet{
            self.bikeList = bikeModelResponse.bikeList!
            self.delegate!.onDataDidLoad()
        }
    }
    func getAvailableBike(){
        let _ = provider.request(.getAvailableBike)
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
                    break
                }
                
        }
        
    }
    override func showError(error : Moya.Error){
        guard let errorResponse = error.response else{
            return
        }
        switch errorResponse.statusCode {
        case 400:
            print("error")
        case 406:
            print("error")
        default:
            print("error")
        }
    }
}
