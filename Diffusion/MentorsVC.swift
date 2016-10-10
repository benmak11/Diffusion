//
//  MentorsVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/9/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class MentorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mentorTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mentorTableView.delegate = self
        mentorTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "MentorsCell") as! MentorsCell
    }

    
    @IBAction func MentorsSettingsBtnPressed(_ sender: AnyObject){
        
    }

}
