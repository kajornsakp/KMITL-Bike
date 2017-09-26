//
//  CheckUpdateResponse.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/5/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class CheckUpdateResponse: NSObject {
    var requireUpdate : Bool?
    var updateUrl : String?
    var criticalVersion : String?
    init(withDictionary dict : AnyObject) {
        self.requireUpdate = dict["requires_update"] as? Bool
        self.updateUrl = dict["update_url"] as? String
        self.criticalVersion = dict["critical_version"] as? String
    }
}
