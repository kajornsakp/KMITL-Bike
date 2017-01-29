//
//  MoreButtonTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/12/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

enum ButtonType{
    case about,logout
}
class MoreButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonImageView : UIImageView!
    @IBOutlet weak var buttonTitleLabel : UILabel!
    static let nibName = "MoreButtonTableViewCell"
    var buttonType : ButtonType!{
        didSet{
            self.updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(){
        switch self.buttonType! {
        case .about:
            self.buttonImageView.image = #imageLiteral(resourceName: "kmitlbike_more_button_about")
            self.buttonTitleLabel.text = "About"
        case .logout:
            self.buttonImageView.image = #imageLiteral(resourceName: "kmitlbike_more_button_logout")
            self.buttonTitleLabel.text = "Logout"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
