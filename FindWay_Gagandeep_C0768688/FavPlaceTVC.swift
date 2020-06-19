//
//  FavPlaceTVC.swift
//  FindWay_Gagandeep_C0768688
//
//  Created by Gagan on 2020-06-14.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit

class FavPlaceTVC: UITableViewController {

    let defaults = UserDefaults.standard
    
    
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
        return Favplaces.fpArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favcell"){
            
//            let cy  =   UserDefaults.standard.string(forKey: "city")
//            let st  =   UserDefaults.standard.string(forKey: "street")
//
        cell.textLabel?.text = Favplaces.fpArray[indexPath.row].city
        //cell.detailTextLabel?.text = Favplaces.fpArray[indexPath.row].city

//            cell.textLabel?.text = st
//                 cell.detailTextLabel?.text = cy
//           
//            print(" saved value"+street!)
        
        

        // Configure the cell...

        return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            
            Favplaces.fpArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // update user default
            // update the user default also here
             //lat
             var temp_lat = [Double]()
             
             
             
             //long
             var temp_long = [Double]()
             //street
             var temp_street = [String]()
             //city
             var temp_city = [String]()
            
             for place in Favplaces.fpArray{
                 
                 temp_lat.append(place.lat)
                 temp_long.append(place.long)
                 temp_city.append(place.city)
                 temp_street.append(place.street)
                 
             }
             
             
             
             self.defaults.set(temp_lat, forKey: "lat")
             self.defaults.set(temp_long, forKey: "long")
             self.defaults.set(temp_street, forKey: "street")
             self.defaults.set(temp_city, forKey: "city")
        }
        return UISwipeActionsConfiguration(actions: [delAction])
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let editedPlace =  Favplaces.fpArray[indexPath.row]
            print("All data")
    print(Favplaces.fpArray[0].lat)
    print(Favplaces.fpArray[0].long)
    print(Favplaces.fpArray[0].street)
            defaults.set(editedPlace.lat, forKey: "latitude")
            defaults.set(editedPlace.long, forKey: "longitude")
           defaults.set(true, forKey: "bool")
           defaults.set(indexPath.row, forKey: "edit")
           let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! editFavViewController
    mapVC.location_index = indexPath.row
           self.navigationController?.pushViewController(mapVC, animated: true)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
