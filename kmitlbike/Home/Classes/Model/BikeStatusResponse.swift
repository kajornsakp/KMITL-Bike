//
//  BikeStatusResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

class BikeStatusResponse : BaseResponse{
    var bikeMac : String?
    var passcode : String?
    var currentLat : String?
    var currentLong : String?
    var totalTime : String?
    var totalDistance : String?
    var routeLine : String?
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        self.bikeMac = dict["bike_mac"] as? String
        self.passcode = dict["passcode"] as? String
        self.totalTime = dict["total_time"] as? String
        self.totalDistance = dict["total_distance"] as? String
        self.currentLat = dict["current_lat"] as? String
        self.currentLong = dict["current_long"] as? String
        self.routeLine = dict["route_line"] as? String
    }
}


