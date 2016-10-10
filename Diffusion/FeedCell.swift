//
//  FeedCell.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postStatusTextView: UITextView!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var numberOfLikesLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
