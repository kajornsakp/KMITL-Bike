//
//  LoginForm.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import CoreLocation

class LoginForm : NSObject{
    var username : String = ""
    var password : String = ""
    
    func toDict() -> [String : AnyObject] {
        var dict = [String: AnyObject]()
        dict["username"] = username as AnyObject?
        dict["password"] = password as AnyObject?
        return dict
    }
}

class SignupForm : NSObject{
    var username : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var gender : Int = 0
    var email : String = ""
    var mobileNumber : String = ""
    
    func toDict() -> [String : AnyObject] {
        var dict = [String: AnyObject]()
        dict["username"] = username as AnyObject?
        dict["first_name"] = firstName as AnyObject?
        dict["last_name"] = lastName as AnyObject?
        dict["gender"] = gender as AnyObject?
        dict["email"] = email as AnyObject?
        dict["phone_no"] = mobileNumber as AnyObject?
        
        return dict
    }
    
}

class ReturnForm : NSObject{
    var totalTime : String = ""
    var totalDistance : String = ""
    var routeLine : [CLLocation] = [CLLocation]()
    var bikeBarcode : String = ""
    
    func toDict()->[String:AnyObject]{
        var dict = [String:AnyObject]()
        dict["total_time"] = totalTime as AnyObject?
        dict["total_distance"] = totalDistance as AnyObject?
        dict["bike_barcode"] = bikeBarcode as AnyObject?
        dict["route_line"] = getRouteString(routeLine: routeLine) as AnyObject?
        return dict
    }
    
    func getRouteString(routeLine : [CLLocation])->String{
        var outputString = ""
        let _ = routeLine.map{
            let lat = $0.coordinate.latitude
            let long = $0.coordinate.longitude
            let time = $0.timestamp.timeIntervalSince1970
            outputString += "{\"lat\":\(lat),\"lng\":\(long),\"time\":\(time)},"
        }
        outputString = String(outputString.characters.dropLast())
        return "[\(outputString)]"
    }
}

