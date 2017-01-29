//
//  LoginRouter.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Moya
import RxSwift


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let endpointClosure = { (target: KmitlBikeService) -> Endpoint<KmitlBikeService> in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(target)
    if target.requiresAnyToken{
        return defaultEndpoint.adding(newHttpHeaderFields: ["Authorization": UserSession.sharedInstance.data.token ?? ""])
    }
    else{
        return defaultEndpoint
    }
}

let provider = RxMoyaProvider<KmitlBikeService>(endpointClosure : endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

//let unitTestProvider = MoyaProvider<KmitlBikeService>(endpointClosure: KmitlBikeServiceEndpointClosure, stubClosure: MoyaProvider.DelayedStub(3))

enum KmitlBikeService{
    case login(form : LoginForm)
    case signup(form : SignupForm)
    case borrow(bikeMac : String)
    case returnBike(totalTime : String,totalDistance : String,routeLine : [RoutePoint])
    case getHistory
    case getAvailableBike
    case checkUpdate(version : String)
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
        case .getHistory:
            return "/api/v1/user/history/"
        case .getAvailableBike:
            return "/api/v1/services/available/"
        case .checkUpdate:
            return "/api/v1/services/check_update/"
        }
    }
    
    var method : Moya.Method{
        switch self {
        case .login,.signup,.borrow,.returnBike,.checkUpdate:
            return .post
        case .getHistory,.getAvailableBike:
            return .get
        }
    }
    
    var parameters : [String : Any]?{
        switch self{
        case .login(let form):
            return form.toDict()
        case .signup(let form):
            return form.toDict()
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
        case .getHistory,.getAvailableBike:
            return [:]
        case .checkUpdate(let version):
            return ["platform":"iOS","app_version":version]
        }
    }
    
    var sampleData: Data{
        switch self {
        case .login(_):
            return "{\"result\": \"success\"}".data(using: String.Encoding.utf8)!
        case .signup(_):
            return "{\"result\": \"success\"}".data(using: String.Encoding.utf8)!
        default:
            return NSData() as Data
        }
    }
    
    var task : Task{
        switch self {
        default:
            return .request
        }
    }
}

extension KmitlBikeService{
    public var requiresAnyToken: Bool {
        switch self {
        case .login,.checkUpdate:
            return false
        case .borrow,.returnBike,.getHistory,.getAvailableBike:
            return true
        default:
            return true
        }
    }
}
