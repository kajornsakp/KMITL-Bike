//
//  RoundTextField.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 3/6/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit



@IBDesignable
class RoundTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0
    @IBInspectable var corner : UIRectCorner = [.allCorners]
    @IBInspectable var topLeft : Bool = true
    @IBInspectable var topRight : Bool = true
    @IBInspectable var bottomLeft : Bool = true
    @IBInspectable var bottomRight : Bool = true
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCorner()
        self.setupTextFieldMask()
    }
    func setCorner(){
        if topLeft && topRight && !bottomLeft && !bottomRight{
            self.corner = [.topLeft,.topRight]
        }
        else if !topLeft && !topRight && bottomLeft && bottomRight{
            self.corner = [.bottomLeft,.bottomRight]
        }
        else if topLeft && !topRight && bottomLeft && !bottomRight{
            self.corner = [.topLeft,.bottomLeft]
        }
        else if !topLeft && topRight && !bottomLeft && bottomRight{
            self.corner = [.topRight,.bottomRight]
        }
    }
    func setupTextFieldMask(){
        self.roundCorners(textField: self, corner: corner, radius: self.cornerRadius)
    }
    private func roundCorners(textField : UITextField,corner: UIRectCorner,radius : CGFloat){
        let bounds = textField.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
