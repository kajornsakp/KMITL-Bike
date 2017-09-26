//
//  ReturnButtonViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import SVProgressHUD

class ReturnButtonViewModel: BaseViewModel {
    func returnBike(){
        self.delegate?.onDataDidLoad()
    }
}
