//
//  CreditPeopleTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/16/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class CreditPeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var positionLabel : UILabel!
    
    var peopleCredit : CreditModel!{
        didSet{
            self.updateUI()
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
    
    func updateUI(){
        self.nameLabel.text = peopleCredit.name
        self.positionLabel.text = peopleCredit.position
    }
    
}
