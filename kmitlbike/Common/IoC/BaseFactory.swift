//
//  BaseFactory.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Swinject

protocol BaseFactoryProtocol {
    func setup()
}

class BaseFactory: NSObject, BaseFactoryProtocol {
    let container = Container()
    
    func setup() {
    }
    
    func resolve<T>(service: T.Type) -> T {
        return container.resolve(service)!
    }
    
    func resolve<T>(service: T.Type, name: String?) -> T {
        return container.resolve(service, name: name)!
    }
}
