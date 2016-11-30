//
//  BaseResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


public class BaseResponse : NSObject{
    
    public var result: String?
    
    public required init(withDictionary dict: AnyObject) {
        self.result = dict["result"] as? String
    }
}
