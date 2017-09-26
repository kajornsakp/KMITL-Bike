//
//  BikeCircleButton.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/20/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class BikeCircleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        self.layer.cornerRadius = self.layer.bounds.width/2
    }

}
