//
//  HistoryResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/10/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

class HistoryModel : NSObject{
    var id : Int?
    var totalTime : String?
    var borrowDate : String?
    var borrowTime : String?
    var bikeName : String?
    var totalDistance : String?
    var routeLine : [RoutePoint]?
    
    init(withDictionary dict : AnyObject){
        self.id = dict["id"] as? Int
        self.totalTime = dict["total_time"] as? String
        self.borrowDate = dict["borrow_date"] as? String
        self.borrowTime = dict["borrow_time"] as? String
        self.bikeName = dict["bike_name"] as? String
        self.totalDistance = dict["total_distance"] as? String
        if let data = dict["route_line"] as? [AnyObject]{
            self.routeLine = data.map{ RoutePoint(withDictionary: $0 as! [String : AnyObject]) }
        }
    }
}
class HistoryResponse: BaseResponse {
    var historyList : [HistoryModel]?
    required public init(withDictionary dict : AnyObject) {
        super.init(withDictionary : dict)
        if let data = dict["history_list"] as? [AnyObject]{
            historyList = data.map{ HistoryModel(withDictionary: $0 as! [String : AnyObject] as AnyObject) }
        }
        
    }
}
