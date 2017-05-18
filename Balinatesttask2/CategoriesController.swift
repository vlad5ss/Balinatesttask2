//
//  CategoriesController.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class CategoriesController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var categoryTable: UITableView!
    
    let loadingCategoriesName = LoadingInformation.sharedInstance
    
    let categoryImages = ["patimaker", "pizza", "set", "rolls", "addditive", "dessert", "drink", "shashlyk", "sushi", "kombo", "lapsha", "zakuski", "sup", "salad", "warm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDishes" {
            let nav = segue.destination as! UINavigationController
            let dishesView = nav.topViewController as! DishesController
            let indexPath = self.categoryTable.indexPathForSelectedRow
            let selectedCategory = self.loadingCategoriesName.categories[(indexPath?.row)!].categoryId
            dishesView.categoryId = selectedCategory
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loadingCategoriesName.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.categoryImage.image = UIImage(named: categoryImages[indexPath.row])
        cell.categoryName.text = self.loadingCategoriesName.categories[indexPath.row].categoryName
        
        return cell
    }
    
}

