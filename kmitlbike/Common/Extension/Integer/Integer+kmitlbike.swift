//
//  Integer+kmitlbike.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 2/6/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


extension Int{
    
    /// toTimeString extension for Int
    ///
    /// - Returns: String of time format XX:XX:XX
    func toTimeString()->String{
        let hours = self / 3600
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    
}

extension String{
    func toIntSec()->Int{
        let timeArray = self.characters.split{ $0 == ":"}.map{(x)->Int in return Int(String(x))!}
        let hour = timeArray[0]*3600
        let minute = timeArray[1]*60
        let second = timeArray[2]
        return hour+minute+second
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
