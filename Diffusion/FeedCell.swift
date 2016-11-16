//
//  FeedCell.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postStatusTextView: UITextView!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var numberOfLikesLbl: UILabel!
    @IBOutlet weak var likeBtn: UIImageView!
    @IBOutlet weak var commentBtn: UIImageView!
    
    var feed: Feed!
    var likesRef: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeBtn.addGestureRecognizer(tap)
        likeBtn.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Feed) {
        self.feed = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        self.usernameLbl.text = USERNAME
        self.profileImg.image = PROFILE_PICTURE
        self.postStatusTextView.text = post.feedDescription
        self.subjectLbl.text = post.subjectPost
        self.numberOfLikesLbl.text = "\(post.likes)"
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.likeBtn.image = UIImage(named: "empty-heart")
            } else {
                self.likeBtn.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer){
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.likeBtn.image = UIImage(named: "filled-heart")
                self.feed.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likeBtn.image = UIImage(named: "empty-heart")
                self.feed.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }

}
