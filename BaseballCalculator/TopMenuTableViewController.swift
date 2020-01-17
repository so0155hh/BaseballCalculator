//
//  TopMenuTableViewController.swift
//  BaseballCalculator
//
//  Created by 桑原　望 on 2019/12/21.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit

class TopMenuTableViewController: UITableViewController {

    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var obpLabel: UILabel!
    @IBOutlet weak var slgLabel: UILabel!
    @IBOutlet weak var opsLabel: UILabel!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
       super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {

        let resultAverage = userDefaults.string(forKey: "average")  
        averageLabel.text = resultAverage
        let resultObp = userDefaults.string(forKey: "obp")
        obpLabel.text = resultObp        
        let resultSlg = userDefaults.string(forKey: "slg")
        slgLabel.text = resultSlg
        let resultOps = userDefaults.string(forKey: "ops")
        opsLabel.text = resultOps
   }  
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
