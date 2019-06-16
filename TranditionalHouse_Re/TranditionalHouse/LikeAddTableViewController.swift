//
//  LikeAddTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit



class LikeAddTableViewController: UITableViewController {

    var titleKorean : String!
    
    @IBAction func cancelToAddViewController(segue: UIStoryboardSegue) {
        
    }
    @IBAction func saveAddLike(segue: UIStoryboardSegue){
        if let addhouseListViewController = segue.source as? AddHouseListTableViewController {
            if let like = addhouseListViewController.like {
                likeadd.append(like)
                
                let indexPath = IndexPath(row: likeadd.count-1, section:0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
   // var likeadd:[Like] = []
    var likeadd:[Like] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likeadd.count
    }

    func imageForRating(rating: Int) -> UIImage? {
         let imageName = "star\(rating)"
        return UIImage(named: imageName)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCell", for: indexPath)
        
        let like = likeadd[indexPath.row] as Like
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = like.name
        }
        if let memoLabel = cell.viewWithTag(101) as? UILabel {
            memoLabel.text = like.memo
        }
        if let ratingImageView = cell.viewWithTag(102) as? UIImageView {
            ratingImageView.image = self.imageForRating(rating: like.rating)
        }
        
       // cell.textLabel?.text = like.name
       // cell.detailTextLabel?.text = like.memo
        
        
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "segueToLikeAdd" {
            if let addhouselistViewController = segue.destination as? AddHouseListTableViewController {
                addhouselistViewController.titleKorean = self.titleKorean
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
