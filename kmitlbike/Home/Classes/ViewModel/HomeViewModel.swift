//
//  HomeViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/22/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SVProgressHUD


class HomeViewModel: BaseViewModel {
    
    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    var borrowBikeResponse : BaseResponse!
    var currentBike : BikeModel!
    weak var borrowBikeDelegate : BorrowBikeDelegate!
    func borrowBike(bikeMac : String){
        provider.request(.borrow(bikeMac: bikeMac))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    self.borrowBikeResponse = BorrowBikeResponse(withDictionary: element as AnyObject)
                    self.checkResponse()
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break

        }
            
    }
    }
    func checkResponse(){
        guard let response = borrowBikeResponse else{
            return
        }
        if(response.result == "success"){
            self.borrowBikeDelegate.onBorrowBikeSuccess(bike : currentBike)
        }else{
            self.borrowBikeDelegate.onBorrowBikeFailed(message: response.result ?? "Error")
        }
    }
}
