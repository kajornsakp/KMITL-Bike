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
    var borrowBikeResponse : BorrowBikeResponse!
    var userStatusResponse : BikeStatusResponse!{
        didSet{
            self.delegate?.onDataDidLoad()
        }
    }
    var currentBike : RidingBikeModel!
    weak var borrowBikeDelegate : BorrowBikeDelegate!
    func borrowBike(barcode : String){
        SVProgressHUD.show()
        let _ = provider.request(.borrow(barcode: barcode))
            .mapJSON()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    self.borrowBikeResponse = BorrowBikeResponse(withDictionary: element as AnyObject)
                    self.checkResponse()
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                    break
                default:
                    break

        }
            
    }
    }
    private func checkResponse(){
        guard let response = borrowBikeResponse else{
            return
        }
        if(response.result == "success"){
            self.borrowBikeDelegate.onBorrowBikeSuccess(passcode : response.passcode!)
        }else{
            self.borrowBikeDelegate.onBorrowBikeFailed(message: response.result ?? "Error")
        }
    }
    
    func getStatus(){
        SVProgressHUD.show()
        let _ = provider.request(.getStatus)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{
                event in
                switch event{
                case .next(let element):
                    SVProgressHUD.dismiss()
                    self.userStatusResponse = BikeStatusResponse(withDictionary: element as AnyObject)
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    break
                }
        }
    }
    
}
