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
    case borrow(barcode : String)
    case returnBike(form : ReturnForm)
    case getHistory
    case getAvailableBike
    case checkUpdate(version : String)
    case getStatus
    case getTermsCondition
    case updateUserLocation(form : UpdateForm)
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
        return URL(string: "https://app.greenkmitl.com")!
    }
    var path : String{
        switch self {
        case .login:
            return "/api/v1/auth/login/"
        case .signup:
            return "/api/v1/services/register/"
        case .borrow:
            return "/api/v2/user/borrow/"
        case .returnBike:
            return "/api/v2/user/return/"
        case .getHistory:
            return "/api/v1/user/history/"
        case .getAvailableBike:
            return "/api/v1/services/available/"
        case .checkUpdate:
            return "/api/v1/services/check_update/"
        case .getStatus:
            return "/api/v1/user/status"
        case .getTermsCondition:
            return "/api/v1/services/get_terms_conditions"
        case .updateUserLocation:
            return "/api/v1/user/update_user_location"
        }
    }
    
    var method : Moya.Method{
        switch self {
        case .login,.signup,.borrow,.returnBike,.checkUpdate,.updateUserLocation:
            return .post
        case .getHistory,.getAvailableBike,.getStatus,.getTermsCondition:
            return .get
        }
    }
    
    var parameters : [String : Any]?{
        switch self{
        case .login(let form):
            return form.toDict()
        case .signup(let form):
            return form.toDict()
        case .borrow(let barcode):
            return ["bike_barcode":barcode]
        case .returnBike(let form):
            return form.toDict()
        case .checkUpdate(let version):
            return ["platform":"iOS","app_version":version]
        case .updateUserLocation(let form):
            return form.toDict()
        default:
            return [:]
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
        case .login,.checkUpdate,.getTermsCondition:
            return false
        case .borrow,.returnBike,.getHistory,.getAvailableBike,.getStatus,.updateUserLocation:
            return true
        default:
            return true
        }
    }
}
