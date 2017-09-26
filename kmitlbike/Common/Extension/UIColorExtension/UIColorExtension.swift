//
//  UIColorExtension.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(red: Int,green: Int,blue: Int) {
        assert(red   >= 0 && red   <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue  >= 0 && blue  <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

public enum KmitlColor {
    
    case Yellow
    case YellowGreen
    case DimYellowGreen
    case Green
    case DarkGreen
    case MediumAquamarine
    case Aquamarine
    case LightCoral
    case Coral
    case Orange
    case DarkOrange
    case LightPurple
    case Purple
    case DarkPurple
    case DimBrown
    case DarkBrown
    case DarkGray
    case MediumGray
    case Gray
    case LightGray
    case DimLightGray
    case ExtraLightGray
    case ExtraExtraLightGray
    case White
    case Black
    case BlackAlpha_10
    case BlackAlpha_20
    case ClearTransparent
    case Pink
    case MainGreenColor
    case LightMainGreenColor
    
    public func color() -> UIColor {
        switch self {
        case .Yellow:
            return UIColor(netHex: 0xffe100)
        case .YellowGreen:
            return UIColor(netHex: 0xcdef62)
        case .DimYellowGreen:
            return UIColor(netHex: 0xaee144)
        case .Green:
            return UIColor(netHex: 0x8dc63f)
        case .DarkGreen:
            return UIColor(netHex: 0x74a822)
        case .MediumAquamarine:
            return UIColor(netHex: 0x32ceb0)
        case .Aquamarine:
            return UIColor(netHex: 0x1db195)
        case .LightCoral:
            return UIColor(netHex: 0xff807d)
        case .Coral:
            return UIColor(netHex: 0xea625e)
        case .Orange:
            return UIColor(netHex: 0xff9f50)
        case .DarkOrange:
            return UIColor(netHex: 0xe28436)
        case .LightPurple:
            return UIColor(netHex: 0xa9a9f7)
        case .Purple:
            return UIColor(netHex: 0x7f7fde)
        case .DarkPurple:
            return UIColor(netHex: 0xA48DC3)
        case .DimBrown:
            return UIColor(netHex: 0x604e48)
        case .DarkBrown:
            return UIColor(netHex: 0x58443d)
        case .DarkGray:
            return UIColor(netHex: 0x808080)
        case .MediumGray:
            return UIColor(netHex: 0x999999)
        case .Gray:
            return UIColor(netHex: 0xcccccc)
        case .LightGray:
            return UIColor(netHex: 0xd5d5d5)
        case .DimLightGray:
            return UIColor(netHex: 0xb9b9b9)
        case .ExtraLightGray:
            return UIColor(netHex: 0xe6e6e6)
        case .ExtraExtraLightGray:
            return UIColor(netHex: 0xF0F0F0)
        case .White:
            return UIColor(netHex: 0xffffff)
        case .Black:
            return UIColor(netHex: 0x000000)
        case .BlackAlpha_10:
            return UIColor(netHex: 0x10000000)
        case .BlackAlpha_20:
            return UIColor(netHex: 0x20000000)
        case .Pink:
            return UIColor(netHex: 0xF196BF)
        case .ClearTransparent:
            return UIColor.clear
        case .MainGreenColor:
            return UIColor(netHex: 0x5D8730)
        case .LightMainGreenColor:
            return UIColor(netHex: 0x90C225)
        }
    }
}
