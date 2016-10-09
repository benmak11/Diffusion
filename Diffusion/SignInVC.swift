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

class SignInVC: UIViewController {
    
    var animEngine: AnimationEngine!

    @IBOutlet weak var facebookSignInLbl: NSLayoutConstraint!
    @IBOutlet weak var facebookLoginConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                print("BEN : Unable to authenticate with Facebook - \(error)")
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
                print("BEN: Unable to authenticate with Firebase using Facebook- \(error)")
            } else {
                print("BEN: Successfully authenticated with Firebase using Facebook")
                if let user = user {
                    self.completSignIn(id: user.uid)
                }
            }
        })
    }
    
    func completSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("BEN: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

