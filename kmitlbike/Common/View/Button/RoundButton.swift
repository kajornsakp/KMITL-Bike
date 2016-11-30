//
//  RoundButton.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/16/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white
    @IBInspectable var borderWidth:CGFloat = 1
    @IBInspectable var cornerRadius:CGFloat = 5
    
    
    //this init called, when storyboards UI objects created:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //during developing IB fires this init to create object
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    //required method to present changes in IB
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func setupViews() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
    }
}
