//
//  CommonGlobal.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/17/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import CoreLocation

class RoutePoint{
    var lat : CLLocationDegrees?
    var lng : CLLocationDegrees?
    var time : TimeInterval?
    
    init(lat:CLLocationDegrees,lng:CLLocationDegrees,time:TimeInterval){
        self.lat = lat
        self.lng = lng
        self.time = time
    }
    init(withDictionary dict : [String: AnyObject]){
        self.lat = dict["lat"] as? CLLocationDegrees
        self.lng = dict["lng"] as? CLLocationDegrees
        self.time = dict["time"] as? TimeInterval
    }
}


