//
//  Info.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Moya
import SVProgressHUD

public class BaseViewModel : NSObject{
    public weak var delegate: BaseViewModelDelegate?
    
    required public init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
    func showError(error : Moya.Error){
        guard let errorResponse = error.response else{
            return
        }
        switch errorResponse.statusCode {
        case 400:
            print("error")
        case 406:
            SVProgressHUD.showError(withStatus: errorResponse.description)
        case 500...599:
            SVProgressHUD.showError(withStatus: "Invalid Bike")
        default:
            print("error")
        }
    }
}
