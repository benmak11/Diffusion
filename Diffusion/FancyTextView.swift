//
//  FancyTextView.swift
//  Diffusion
//
//  Created by Baynham Makusha on 11/2/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class FancyTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }

}
