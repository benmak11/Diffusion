//
//  MessageContactsCell.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/25/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class MessageContactsCell: UITableViewCell {

    @IBOutlet weak var messagesProfile: CircleCustomImage!
    @IBOutlet weak var senderLbl: UILabel!
    @IBOutlet weak var timeReceivedLbl: UILabel!
    @IBOutlet weak var snippetMessageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
