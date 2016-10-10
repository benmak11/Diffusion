//
//  NotificationsCell.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {

    @IBOutlet weak var profileImg: CircleCustomImage!
    @IBOutlet weak var notificationIconImg: UIImageView!
    @IBOutlet weak var notificationDetailsLbl: UILabel!
    @IBOutlet weak var postDateTimeDiffLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
