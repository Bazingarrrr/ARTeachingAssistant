//
//  modeSelectionVC.swift
//  FYP2.3
//
//  Created by Jason on 8/1/2021.
//

import UIKit

class modeSelectionVC: UITableViewController {

    var mode:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "modeCell", for: indexPath) as! ModeCell
        
        switch indexPath.row {
        case 0:
            cell.set( modeName: "FourBarLinkage", modeImage: UIImage(named: "FourBarLinkage") )
        case 1:
            cell.set(modeName: "CrankSlider", modeImage: UIImage(named: "CrankSlider") )
        case 2:
            cell.set(modeName: "FourStrokeEngine", modeImage: UIImage(named: "FourStrokeEngine"))
        default:
            cell.set( modeName: "FourBarLinkage", modeImage: UIImage(named: "FourBarLinkage") )
            print("No Image matched")
        }
        

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "modeCell", for: indexPath) as! ModeCell
//
//        mode = cell.modeName.text!
//        print(mode)
//        performSegue(withIdentifier: "goToARView", sender: self)
//
//
//    }
    

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
        
        let indexPath = tableView.indexPathForSelectedRow
        
        switch indexPath!.row {
        case 0:
            mode = "FourBarLinkage"
        case 1:
            mode = "CrankSlider"
        default:
            mode = ""
        }
        
        // Get the new view controller using segue.destination.
        if let nextVC = segue.destination as? ARSceneViewController {
            
            nextVC.mode = mode
        }
        
    }


}
