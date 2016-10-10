//
//  MentorsCell.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class MentorsCell: UITableViewCell {

    @IBOutlet weak var profileImg: CircleCustomImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func askForHelpBtnPressed(_ sender: Any) {
    }
}
