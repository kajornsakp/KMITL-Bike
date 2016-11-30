//
//  LoginRouter.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Moya


let KmitlBikeServiceEndpointClosure = { (target: KmitlBikeService) -> Endpoint<KmitlBikeService> in
    let endpoint: Endpoint<KmitlBikeService> = Endpoint<KmitlBikeService>(URL: url(target),
                                                      sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                                      method: target.method,
                                                      parameters: target.parameters)
    return endpoint.endpointByAddingHTTPHeaderFields(target.headers())
}


let provider = MoyaProvider<KmitlBikeService>(endpointClosure: KmitlBikeServiceEndpointClosure, stubClosure: MoyaProvider.NeverStub)

let unitTestProvider = MoyaProvider<KmitlBikeService>(endpointClosure: KmitlBikeServiceEndpointClosure, stubClosure: MoyaProvider.DelayedStub(3))

enum KmitlBikeService{
    case login(username : String , password : String)
    case signup(username:String,first_name:String,last_name:String,gender:Int,email:String,phone_no:String)
    case borrow(bikeMac : String)
    case returnBike(totalTime : String,totalDistance : String,routeLine : [RoutePoint])
    
}


private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}


extension KmitlBikeService : TargetType{
    var baseURL : URL{
        return URL(string: "http://161.246.94.246:1995")!
    }
    var path : String{
        switch self {
        case .login:
            return "/api/v1/auth/login/"
        case .signup:
            return "/api/v1/services/register/"
        case .borrow:
            return "/api/v1/user/borrow/"
        case .returnBike:
            return "/api/v1/user/return/"
            
        }
    }
    
    var method : Moya.Method{
        switch self {
        case .login,.signup,.borrow,.returnBike:
            return .POST
        }
    }
    
    var parameters : [String : Any]?{
        switch self{
        case .login(let username, let password):
            return ["username":username,"password":password]
        case .signup(let username,let firstName, let lastName, let gender, let email,let phoneNum):
            return [
                "username" :username,
                "first_name":firstName,
                "last_name":lastName,
                "gender":gender,
                "email":email,
                "phone_no":phoneNum]
        case .borrow(let bikeMac):
            return ["bike_mac":bikeMac]
        case .returnBike(let totalTime,let totalDistance,let routeLine):
            var strRouteLine = ""
            for coordinate in routeLine {
                let strObj = "{\"lat\":\(coordinate.lat),\"lng\":\(coordinate.lng),\"time\":\(coordinate.time)},"
                strRouteLine += strObj
            }
            strRouteLine = String(strRouteLine.characters.dropLast())
            
            return ["total_time":totalTime,"total_distance":totalDistance,"route_line":strRouteLine]
        }
    }
    
    var sampleData: Data{
        switch self {
        case .login(_,_):
            return "{\"result\": \"success\"}".data(using: String.Encoding.utf8)!
        case .signup(_,_,_,_,_,_):
            return "{\"result\": \"success\"}".data(using: String.Encoding.utf8)!
        default:
            return NSData() as Data
        }
    }
    
    var task : Task{
        switch self {
        case .login,.signup,.borrow,.returnBike:
            return .request
       
        }
    }
    public func headers() -> [String: String] {
        var assigned: [String: String] = [
            "Accept": "application/json",
            "Accept-Language": "",
            "Content-Type": "application/json",
            ]
        
        
        if self.requiresAnyToken {
            assigned["AUTHORIZATION"] =  UserData.sharedInstance.token ?? ""
        }
        return assigned
    }
    
}

extension KmitlBikeService{
    public var requiresAnyToken: Bool {
        switch self {
        case .login:
            return false
        default:
            return true
        }
    }
}
