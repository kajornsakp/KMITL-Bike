//
//  ReturnBikeViewModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import CoreLocation
import Moya
import RxSwift

class ReturnBikeViewModel: BaseViewModel {

    var provider = ViewControllerFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    weak var locationDelegate: BikeMapDelegate!
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation?
    var routeList : [CLLocation] = [CLLocation]()
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
        
    }
    
    
}

extension ReturnBikeViewModel : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else{
            return
        }
        if currentLocation.speed <= 0 {
            return
        }
        self.routeList.append(currentLocation)
        self.locationDelegate.onMapDidUpdate(location: currentLocation)
    }
}
