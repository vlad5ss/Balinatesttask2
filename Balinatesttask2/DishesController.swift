//
//  DishesController.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//
import UIKit
import AlamofireImage

class DishesController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var dishesTable: UITableView!
    var categoryId = ""
    
    let loadingDishesInfo = LoadingInformation.sharedInstance
    
    var tmpDishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let count = self.loadingDishesInfo.dishes.count
        for i in 0 ..< count {
            if (self.loadingDishesInfo.dishes[i].categoryId == categoryId) {
                tmpDishes.append(self.loadingDishesInfo.dishes[i])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showInfo" {
            let nav = segue.destination as! UINavigationController
            let infoView = nav.topViewController as! DishInformationController
            let indexPath = self.dishesTable.indexPathForSelectedRow
            infoView.dishNameSelect = tmpDishes[(indexPath?.row)!].dishName
            infoView.dishImageSelect = tmpDishes[(indexPath?.row)!].dishImageUrl
            infoView.dishWeightSelect = tmpDishes[(indexPath?.row)!].dishWeight
            infoView.dishPriceSelect = tmpDishes[(indexPath?.row)!].dishPrice
            infoView.dishInfoSelect = tmpDishes[(indexPath?.row)!].dishInfo
            infoView.categoryIdSelect = categoryId
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpDishes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishCell
        
        let downloadURL = NSURL(string: tmpDishes[indexPath.row].dishImageUrl)
        cell.dishImage.af_setImage(withURL: downloadURL as! URL)
        cell.dishImage.layer.cornerRadius = 30.0
        cell.dishImage.clipsToBounds = true
        cell.dishName.text = tmpDishes[indexPath.row].dishName
        cell.dishWeight.text = tmpDishes[indexPath.row].dishWeight
        cell.dishPrice.text = tmpDishes[indexPath.row].dishPrice
        return cell
    }
}
