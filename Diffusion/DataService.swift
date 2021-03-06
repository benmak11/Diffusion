//
//  DataService.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/27/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()
let GeoFire_REF = FIRDatabase.database().reference()

class DataService {
    
    // MARK: Created the singleton
    static let ds = DataService()
    
    // MARK: DB References
    private var _REF_BASE = DB_BASE
    private var _REF_FEED = DB_BASE.child("feeds")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_USERS_IN_VICINITY = DB_BASE.child("users_in_vicinity")
    
    // MARK: Geofire instances to be used and marked in database
    let geoFire = GeoFire(firebaseRef: GeoFire_REF)
    
    // MARK: Storage References
    // place storage references here if you need them
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_FEED: FIRDatabaseReference {
        return _REF_FEED
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERS_IN_VICINITY: FIRDatabaseReference {
        return _REF_USERS_IN_VICINITY
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func addUserLocation(uid: String, userLocation: Dictionary<String, Any>){
        REF_USERS_IN_VICINITY.child(uid).updateChildValues(userLocation)
    }
    
}
