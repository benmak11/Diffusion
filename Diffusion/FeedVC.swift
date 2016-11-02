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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    var geoFire: GeoFire!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_FEED.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots{
                    print("SNAP: \(snap)")
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
    }

    @IBAction func FeedSettingsBtnPressed(_ sender: AnyObject){
        
    }
    
    @IBAction func makePostBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPostDetails", sender: Any?.self)
        
    }
    
}
