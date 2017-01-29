//
//  BorrowBikeTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/22/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class BorrowBikeTableViewCell: UITableViewCell {

    @IBOutlet weak var bikeLabel : UILabel!
    @IBOutlet weak var bikeUnlock : UILabel!
    @IBOutlet weak var bikeIcon : UIImageView!
    var bike : BikeModel!{
        didSet{
            self.bikeLabel.text = bike.bikeName
            if(bike.bikeModel == "LA City Green"){
                self.bikeIcon.image = #imageLiteral(resourceName: "kmitlbike_bike_la")
            }else{
                self.bikeIcon.image = #imageLiteral(resourceName: "kmitlbike_bike_giant")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
