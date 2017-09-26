//
//  ServiceProvider.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/10/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import Moya
class ServiceFactory: BaseFactory {
    static let sharedInstance = ServiceFactory()
    
    override init(){
        super.init()
    }
    
    internal override func setup(){
        registerKmitlBikeService()
    }
    private func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    func registerKmitlBikeService(){
        container.register(RxMoyaProvider<KmitlBikeService>.self){_ in
            let provider = RxMoyaProvider<KmitlBikeService>(endpointClosure : endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
            return provider
        }
    }
}
