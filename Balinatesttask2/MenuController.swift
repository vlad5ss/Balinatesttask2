//
//  MenuController.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    @IBOutlet weak var cafeLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeLogo.layer.cornerRadius = 60.0
        cafeLogo.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
