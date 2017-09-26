//
//  MoreInfoTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/12/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTitleLabel : UILabel!
    @IBOutlet weak var infoDetailLabel : UILabel!
    
    var infoKeyValue : [String:String]!{
        didSet{
            self.setupUI()
        }
    }
    static let nibName = "MoreInfoTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupUI(){
        self.infoTitleLabel.text = infoKeyValue.first?.key
        self.infoDetailLabel.text = infoKeyValue.first?.value
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
