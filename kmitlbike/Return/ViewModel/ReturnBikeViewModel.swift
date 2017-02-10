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

    var provider = ServiceFactory.sharedInstance.resolve(service: RxMoyaProvider<KmitlBikeService>.self)
    weak var locationDelegate: BikeMapDelegate!
    weak var timerDelegate : BikeTimerDelegate!
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation!
    var routeList : [CLLocation] = [CLLocation]()
    var updateTimer = Timer()
    var secTimer = Timer()
    var secAmount : Int = 0
    var distanceAmount : Double = 0.0
    var bikeModel : RidingBikeModel!{
        didSet{
            self.setTime()
        }
    }
    func setTime(){
        self.secAmount = Int(Date().timeIntervalSince(self.bikeModel.borrowTime as! Date))
        self.distanceAmount = bikeModel.totalDistance!
        self.routeList = bikeModel.routeLine ?? [CLLocation]()
    }
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    func setupUpdateTimer(){
        if #available(iOS 10.0, *) {
            updateTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true){_ in
                self.updateLocation()
            }
        } else {
            updateTimer = Timer.scheduledTimer(timeInterval: 5,
                                 target: self,
                                 selector: #selector(self.updateLocation),
                                 userInfo: nil,
                                 repeats: true)
        }
    }
    func setupSecTimer(){
        self.secAmount = 0
        if #available(iOS 10.0, *) {
            secTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
                self.increaseSec()
            }
        } else {
            secTimer = Timer.scheduledTimer(timeInterval: 1,
                                            target: self,
                                            selector: #selector(self.increaseSec),
                                            userInfo: nil,
                                            repeats: true)
        }
    }
    
    func updateLocation(){
        let form = UpdateForm()
        form.bikeMac = bikeModel.bikeMac!
        form.totalTime = secAmount.toTimeString()
        form.totalDistance = String(distanceAmount)
        guard let currentLocation = routeList.last else{
            return
        }
        form.latitude = String(currentLocation.coordinate.latitude)
        form.longitude = String(currentLocation.coordinate.longitude)
        form.routeLine = routeList
        let _ = provider.request(.updateUserLocation(form: form))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                switch event{
                case .next(let element):
                    print(element)
                case .error(let error):
                    print(error)
                default:
                    break
                }
                
        }
    }
    
    func increaseSec(){
        self.secAmount += 1
        self.timerDelegate.onSecUpdate()
    }
    func stopUpdating(){
        locationManager.stopUpdatingLocation()
        updateTimer.invalidate()
        secTimer.invalidate()
    }
    func returnBike(withBarcode barcode : String){
        let form = ReturnForm()
        form.bikeBarcode = barcode
        form.totalDistance = String(self.distanceAmount)
        form.totalTime = self.secAmount.toTimeString()
        form.routeLine = self.routeList
        let _ = provider.request(.returnBike(form: form))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe{ event in
                switch(event){
                case .next(let element):
                    self.delegate?.onDataDidLoad()
                case .error(let error):
                    self.checkError(errorResponse: BaseResponse(withDictionary: error as AnyObject))
                default:
                    break
                }
                
        }
    }
    func calculateDistance(){
        guard let firstLocation = self.routeList.first else {
            return
        }
        self.distanceAmount = 0.0
        self.currentLocation = firstLocation
        for coordinate in routeList{
            self.distanceAmount += coordinate.distance(from: currentLocation)/1000
            self.currentLocation = coordinate
        }
        
    }
    func checkError(errorResponse : BaseResponse){
        self.delegate?.onDataDidLoadErrorWithMessage(errorMessage: errorResponse.result ?? "Barcode mismatch")
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
        self.calculateDistance()
        self.locationDelegate.onMapDidUpdate(location: currentLocation)
    }
}
