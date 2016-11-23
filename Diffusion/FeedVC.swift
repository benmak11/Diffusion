//
//  FeedVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/8/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKShareKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    
    var geoFire: GeoFire!
    var feed = [Feed]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUserCredentials()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self
        profileImg.image = PROFILE_PICTURE
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            //print("BEN: --- Location \(currentLocation)")
            Location.sharedInstance.latitube = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            // MARK: Download Feed data
            
            DataService.ds.REF_FEED.queryOrdered(byChild: "postedDate").observe(.value, with: { (snapshot) in
                // THIS IS THE NEW LINE
                self.feed = []
                
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshots{
                        //print("BEN: DATA --- \(snap)")
                        
                        if let feedDict = snap.value as? Dictionary<String, Any> {
                            let key = snap.key
                            let feed = Feed(postKey: key, postData: feedDict)
                            //self.feed.append(feed)
                            self.feed.insert(feed, at: 0)
                            //print("BEN: Feed is --- \(self.feed)")
                        }
                    }
                }
                self.tableView.reloadData()
            })

        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = feed[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell{
            
            cell.configureCell(post: post)
            return cell
        } else {
            return FeedCell()
        }
        //return tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
    }
    
    @IBAction func makePostBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPostDetails", sender: Any?.self)
        
    }
    
    func setUserCredentials(){
        
        /*!
         * Credit given to Enoch Huang for providing this solution:
         * https://studyswift.blogspot.com/2016/01/facebook-sdk-and-swift-display-user.html?showComment=1479285714433#c5684049712303509664
         */
        if ((FBSDKAccessToken.current() != nil )){
            //print("BEN: FB Access Token -- \(FBSDKAccessToken.current().tokenString)")
            //print("BEN: FB Access Persmissions -- \(FBSDKAccessToken.current().permissions)")
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String: Any]
                USERNAME = (data["name"] as? String)!
                //print("BEN: Username is --- \(USERNAME)")
                let facebookId = data["id"] as? String
                let url = URL(string: "https://graph.facebook.com/"+facebookId!+"/picture?type=large&return_ssl_resources=1")
                self.profileImg.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                PROFILE_PICTURE = self.profileImg.image
            })
            connection.start()
            
        }
        
        
    }

    
}
