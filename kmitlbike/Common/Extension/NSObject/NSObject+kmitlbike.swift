//
//  NSObject+kmitlbike.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
