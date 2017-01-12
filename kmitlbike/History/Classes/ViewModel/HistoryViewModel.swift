//
//  HistoryViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/10/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SVProgressHUD
class HistoryViewModel: BaseViewModel {
    
    let provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    weak var historyDelegate : HistoryDelegate!
    var historyList = [HistoryModel]()
    var historyResponse : HistoryResponse!{
        didSet{
            self.historyList = historyResponse.historyList!.sorted{ (a, b) -> Bool in
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                let date = dateFormatter.date(from: a.borrowDate!)
                let date2 = dateFormatter.date(from: b.borrowDate!)
                return date!.compare(date2!) == .orderedDescending
            }
            self.delegate?.onDataDidLoad()
        }
    }
    func getBikeHistory(){
        SVProgressHUD.show()
        provider.request(.getHistory)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                print("event",event)
                switch event{
                case .next(let element):
                    self.historyResponse = HistoryResponse(withDictionary: element as AnyObject)
                case .error(let error):
                    self.showError(error: error as! Moya.Error)
                default:
                    SVProgressHUD.dismiss()
                    break
                }
                
        }

    }
    func showError(error : Moya.Error){
        SVProgressHUD.dismiss()
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
