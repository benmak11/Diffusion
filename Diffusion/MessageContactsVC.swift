//
//  MessageContactsVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/25/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class MessageContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageContactTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageContactTableView.delegate = self
        messageContactTableView.dataSource = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MessageContactsCell") as! MessageContactsCell
    }

}
