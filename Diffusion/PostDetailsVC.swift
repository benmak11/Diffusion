//
//  PostDetailsVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 11/2/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class PostDetailsVC: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postDescription: FancyTextView!
    @IBOutlet weak var subjectTextField: FancyTextField!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        self.setup()

    }
    
    func setup(){
        self.userProfileImg.image = PROFILE_PICTURE
        self.usernameLbl.text = USERNAME
    }
    
    func loadSelectedPostData() {
        
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
    
    func postToFirebase(){
        
        currentLocation = locationManager.location
        Location.sharedInstance.latitube = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        let locLat = Location.sharedInstance.latitube
        let locLong = Location.sharedInstance.longitude
        
        let post: Dictionary<String, Any> = [
            "postDescription": postDescription.text!,
            "subject": subjectTextField.text!,
            "likes": 0,
            "location": ["latitude": locLat,
                         "longitude": locLong]
        ]
        
        let firebasePost = DataService.ds.REF_FEED.childByAutoId()
        firebasePost.setValue(post)
        
        postDescription.text = ""
        subjectTextField.text = ""
    }

    @IBAction func submitPostPressed(_ sender: Any) {
        
        guard let postDesc = postDescription.text, postDesc != "" else {
            print("BEN: You must enter a Post Description")
            return
        }
        guard let subject = subjectTextField.text, subject != "" else {
            print("BEN: You must post a subject you're struggling with")
            return
        }
        
        self.postToFirebase()
        dismiss(animated: true, completion: nil)
    
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
