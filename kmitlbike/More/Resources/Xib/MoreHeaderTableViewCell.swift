//
//  MoreHeaderTableViewCell.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/11/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class MoreHeaderTableViewCell: UITableViewCell {

    @IBOutlet var initialView : UIView!
    @IBOutlet var initialLabel : UILabel!
    @IBOutlet var firstNameLabel : UILabel!
    @IBOutlet var lastNameLabel : UILabel!
    @IBOutlet var maleGenderLabel : UILabel!
    @IBOutlet var femaleGenderLabel : UILabel!
    @IBOutlet var unknownGenderLabel : UILabel!
    @IBOutlet var maleGenderImageView : UIImageView!
    @IBOutlet var femaleGenderImageView : UIImageView!
    @IBOutlet var unknownGenderImageView : UIImageView!
    
    static let nibName = "MoreHeaderTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialView.layer.cornerRadius = self.initialView.frame.width/2
        self.setupUI()
    }
    
    func setupUI(){
        let userModel = UserSession.sharedInstance.data
        var initials = ""
        if let firstName = userModel.firstname{
            self.firstNameLabel.text = firstName
            initials.append(firstName.characters.first!)
        }
        if let lastName = userModel.lastname{
            self.lastNameLabel.text = lastName
            initials.append(lastName.characters.first!)
        }
        self.initialLabel.text  = initials.uppercased()
        if let gender = userModel.gender?.intValue{
            self.setGender(gender: gender)
        }
        
    }

    func setGender(gender : Int){
        switch gender {
        case 1:
            self.setMale(color: KmitlColor.LightMainGreenColor)
        case 2:
            self.setFemale(color: KmitlColor.LightMainGreenColor)
        default:
            self.setUnknown(color: KmitlColor.LightMainGreenColor)
        }
    }
    func setMale(color : KmitlColor){
        if color == .LightMainGreenColor {
            self.maleGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_male_selected")
        }else{
            self.maleGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_male_unselected")
        }
        self.maleGenderLabel.textColor = color.color()
    }
    func setFemale(color : KmitlColor){
        if color == .LightMainGreenColor {
            self.femaleGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_female_selected")
        }else{
            self.femaleGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_female_unselected")
        }
        self.femaleGenderLabel.textColor = color.color()
    }
    func setUnknown(color : KmitlColor){
        if color == .LightMainGreenColor {
            self.unknownGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_unknown_selected")
        }else{
            self.unknownGenderImageView.image = #imageLiteral(resourceName: "kmitlbike_gender_unknown_unselected")
        }
        self.unknownGenderLabel.textColor = color.color()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
