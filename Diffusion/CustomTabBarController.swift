//
//  CustomTabBarController.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        UITabBar.appearance().layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        UITabBar.appearance().layer.shadowOpacity = 0.8
        UITabBar.appearance().layer.shadowRadius = 5.0
        UITabBar.appearance().layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        UITabBar.appearance().tintColor = UIColor.blue
//        UITabBar.appearance().barTintColor = UIColor.white
    }

}
