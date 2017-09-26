//
//  BikeHistoryTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/10/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit


class BikeHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var bikeImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var bikeHistory : HistoryModel!{
        didSet{
            self.bikeImage.image = #imageLiteral(resourceName: "kmitlbike_history_bike_icon_green")
            self.dateLabel.text = bikeHistory.borrowDate
            self.timeLabel.text = bikeHistory.borrowTime
            self.durationLabel.text = bikeHistory.totalTime
            var distanceDouble = Double(bikeHistory.totalDistance!) ?? 0.0
            self.distanceLabel.text = String(format: "%.3f km.",distanceDouble)
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
