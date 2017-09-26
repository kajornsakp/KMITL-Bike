//
//  CommonGlobal.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/6/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

struct Developer {
    static let ENABLED = false
    static let BYPASS_LOGIN = false
    
}

let IC_LATITUTE = 13.730056
let IC_LONGITUTE = 100.775434


class AppConfig{
    static func getApplicationVersion() -> String {
        let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        return versionString
    }
}

class AppRoute{
    static func logout(withNavController navigationController : UINavigationController){
        UserSession.sharedInstance.clearUserSession()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
        let _ = navigationController.popToRootViewController(animated: true)
    }
}
