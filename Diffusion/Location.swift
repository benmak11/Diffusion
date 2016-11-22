//
//  Location.swift
//  Diffusion
//
//  Created by Baynham Makusha on 11/21/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitube: Double!
    var longitude: Double!
}
