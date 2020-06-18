//
//  editFavViewController.swift
//  FindWay_Gagandeep_C0768688
//
//  Created by adithyasai neeli on 2020-06-17.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class editFavViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate  {

    @IBOutlet weak var mapview: MKMapView!
    
    var latitude: Double = UserDefaults.standard.double(forKey: "latitude")
     var longitude: Double = UserDefaults.standard.double(forKey: "longitude")
    override func viewDidLoad() {
        super.viewDidLoad()
         notesSaveLocation()
        // Do any additional setup after loading the view.
    }
    
    func notesSaveLocation(){


        let favplace = MKPointAnnotation()
         favplace.title = "favplace"
         favplace.coordinate = CLLocationCoordinate2D(latitude: latitude ,longitude: longitude)
         mapview.addAnnotation(favplace)
        
          
      }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
