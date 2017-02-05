//
//  BorrowBikeResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/22/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


class BorrowBikeResponse : BaseResponse{
    var passcode : String?
    var bikeMac : String?
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        self.passcode = dict["passcode"] as? String
        self.bikeMac = dict["bike_mac"] as? String
    }
}


