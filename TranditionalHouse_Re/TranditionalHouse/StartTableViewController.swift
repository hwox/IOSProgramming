//
//  StartTableViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 16/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit

class StartTableViewController: UIViewController {

    @IBOutlet weak var MainImage: UIImageView!
    
    @IBOutlet weak var leftDoor: UIImageView!
    @IBOutlet weak var rightDoor: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        UIView.animate(withDuration: 1.5, animations: ({
            self.leftDoor.transform = CGAffineTransform(translationX: -200, y: 0)
        }))
        UIView.animate(withDuration: 1.5, animations: ({
            self.rightDoor.transform = CGAffineTransform(translationX: 200, y: 0)
        }))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem        UIScreen.main.bounds.width
   
    }

    override func viewWillLayoutSubviews() {
        
        MainImage.bounds.width
        MainImage.bounds.height
        
        
        UIScreen.main.bounds.width
        UIScreen.main.bounds.height
    }
    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToStart" {
            
        }
    }
    

}
