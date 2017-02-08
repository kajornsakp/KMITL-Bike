//
//  ReturnBikeProtocol.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import CoreLocation
protocol BikeMapDelegate : class{
    func onMapDidUpdate(location : CLLocation)
}

protocol BikeTimerDelegate : class{
    func onSecUpdate()
}
