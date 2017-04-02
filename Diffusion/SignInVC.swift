//
//  SignInVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/6/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SwiftKeychainWrapper
import pop

class SignInVC: UIViewController, CLLocationManagerDelegate{
    
    var animEngine: AnimationEngine!

    @IBOutlet weak var facebookSignInLbl: NSLayoutConstraint!
    @IBOutlet weak var facebookLoginConstraint: NSLayoutConstraint!
    
    let signInLocationManager = CLLocationManager()
    var signInCurrentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInLocationManager.delegate = self
        
        self.animEngine = AnimationEngine(constraints: [facebookSignInLbl,facebookLoginConstraint])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.animEngine.animateOnScreen(2)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("BEN: ID Found in Keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BEN : Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("BEN: User cancelled Facebook authentication")
            } else {
                print("BEN: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Firebase using Facebook- \(String(describing: error))")
            } else {
                print("BEN: Successfully authenticated with Firebase using Facebook")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        // MARK: Adding the provider for signin
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("BEN: Data saved to keychain \(keychainResult)")
        addUserLocation(id: id)
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    // MARK: Adding the user's current location
    func addUserLocation(id: String){
        self.signInCurrentLocation = self.signInLocationManager.location
        Location.sharedInstance.latitube = self.signInCurrentLocation.coordinate.latitude
        Location.sharedInstance.longitude = self.signInCurrentLocation.coordinate.longitude
        let locLat = Location.sharedInstance.latitube
        let locLong = Location.sharedInstance.longitude
        
        let userLocation = ["location": ["latitude": locLat,
                                         "longitude": locLong]]
        DataService.ds.addUserLocation(uid: id, userLocation: userLocation)
    }
}

