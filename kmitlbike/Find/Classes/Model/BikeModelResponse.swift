//
//  BikeModelResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/14/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


class BikeModel : NSObject{
    var bikeName : String?
    var bikeMac : String?
    var bikeModel : String?
    var passcode : String?
    var currentLat : String?
    var currentLong : String?
    init(withDictionary dict : AnyObject) {
        self.bikeName = dict["bike_name"] as? String
        self.bikeMac = dict["bike_mac"] as? String
        self.bikeModel = dict["bike_model"] as? String
        self.passcode = dict["passcode"] as? String
        self.currentLat = dict["current_lat"] as? String
        self.currentLong = dict["current_long"] as? String
    }
}


class BikeModelResponse: BaseResponse {
    var bikeList : [BikeModel]?
    
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        if let data = dict["bike_list"] as? [AnyObject]{
            self.bikeList = data.map { BikeModel(withDictionary : $0 ) }
        }
    }
}

