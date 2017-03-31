//
//  FeedCollectionViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 3/31/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIStackView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
    }
 
}
