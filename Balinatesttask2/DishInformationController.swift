//
//  DishInformationController.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class DishInformationController: UITableViewController {
    
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishWeight: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishInfo: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var dishNameSelect = ""
    var categoryIdSelect = ""
    var dishImageSelect = ""
    var dishWeightSelect = ""
    var dishPriceSelect = ""
    var dishInfoSelect = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dishName.text = dishNameSelect
        let downloadURL = NSURL(string: dishImageSelect)
        dishImage.af_setImage(withURL: downloadURL as! URL)
        dishWeight.text = dishWeightSelect
        dishPrice.text = dishPriceSelect
        dishInfo.text = dishInfoSelect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToDishes" {
            let nav = segue.destination as! UINavigationController
            let dishesView = nav.topViewController as! DishesController
            dishesView.categoryId = categoryIdSelect
        }
    }
    
}
