//
//  PostDetailsVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 11/2/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class PostDetailsVC: UIViewController {

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postDescription: FancyTextView!
    @IBOutlet weak var subjectTextField: FancyTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loadPostData() {
        
    }

    @IBAction func discardPressed(_ sender: Any) {
        if postDescription != nil {
            postDescription.text = ""
        }
        
        if subjectTextField != nil {
            subjectTextField.text = ""
        }
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func submitPostPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if postDescription != nil {
            postDescription.text = ""
        }
        
        if subjectTextField != nil {
            subjectTextField.text = ""
        }
        
        dismiss(animated: true, completion: nil)
    }
}
