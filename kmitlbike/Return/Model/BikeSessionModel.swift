//
//  BikeSessionModel.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/31/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import CoreLocation


class BikeSessionModel {
    var bikeMac : String?
    var passcode : String?
    var currentLat : String?
    var currentLong : String?
    var totalTime : String?
    var totalDistance : String?
    var routeLine : String?
    
    init(withBikeMac bikeMac : String,passcode: String,currentLat : String,currentLong : String,totalTime : String,totalDistance: String,routeLine : String){
        self.bikeMac = bikeMac
        self.passcode = passcode
        self.currentLat = currentLat
        self.currentLong = currentLong
        self.totalTime = totalTime
        self.totalDistance = totalDistance
        self.routeLine = routeLine
    }
    
    required init(withDictionary dict: AnyObject) {
        self.bikeMac = dict["bike_mac"] as? String
        self.passcode = dict["passcode"] as? String
        self.totalTime = dict["total_time"] as? String
        self.totalDistance = dict["total_distance"] as? String
        self.currentLat = dict["current_lat"] as? String
        self.currentLong = dict["current_long"] as? String
        self.routeLine = dict["route_line"] as? String
    }
    
    func getCurrentLat()->CLLocationDegrees?{
        if let currentLat = self.currentLat{
            return CLLocationDegrees(currentLat)
        }
        return nil
    }
    func getCurrentLong()->CLLocationDegrees?{
        if let currentLong = self.currentLong{
            return CLLocationDegrees(currentLong)
        }
        return nil
    }
    
    func getRouteLine()->[CLLocation]{
        if let routeLine = routeLine{
            if routeLine == "[]"{
                return []
            }
            else{
                let route = "{\"routeLine\":\(routeLine)}"
                let data  = convertToDictionary(text: route.replacingOccurrences(of: "\\", with: ""))
                var output : [CLLocation] = []
                let array = data?["routeLine"] as! NSArray
                let _ = array.map{
                    let latlng = $0 as! [String : Any]
                    let lat = latlng["lat"] as? Double
                    let long = latlng["lng"] as? Double
                    let time = latlng["time"] as? Double
                    let date = NSDate(timeIntervalSince1970: time!)
                    let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                    let location = CLLocation(coordinate: coordinate, altitude: 0.0, horizontalAccuracy: 0.0, verticalAccuracy: 0.0, timestamp: date as Date)
                    output.append(location)
                }
                return output
            }
        }
        return []
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                return json
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
