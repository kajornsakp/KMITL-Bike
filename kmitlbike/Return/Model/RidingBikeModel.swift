//
//  RidingBikeModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/31/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import CoreLocation

class RidingBikeModel : NSObject{
    var bikeMac : String?
    var passcode : String?
    var totalTime : Int?
    var totalDistance : Double?
    var routeLine : [CLLocation]?
    var borrowTime : NSDate?
    init(withBikeMac bikeMac : String,passcode : String,borrowTime : NSDate) {
        self.bikeMac = bikeMac
        self.passcode = passcode
        self.borrowTime = borrowTime
        self.totalTime = 0
        self.totalDistance = 0.0
        self.routeLine = []
        
    }
    
    init(withBikeMac bikeMac : String,passcode : String,borrowTime : NSDate,totalTime : Int,totalDistance : Double,routeLine : [CLLocation]){
        self.bikeMac = bikeMac
        self.passcode = passcode
        self.borrowTime = borrowTime
        self.totalDistance = totalDistance
        self.totalTime = totalTime
        self.routeLine = routeLine
    }
    
}
