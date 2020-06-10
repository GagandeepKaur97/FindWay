//
//  ViewController.swift
//  FindWay_Gagandeep_C0768688
//
//  Created by Gagan on 2020-06-10.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{


    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
       
            
            
        }
    


}

