//
//  KmitlBikeBounceAnimation.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 3/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class KmitlBikeBounceAnimation: RAMBounceAnimation {
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = KmitlColor.LightMainGreenColor.color()
    }
    
}
