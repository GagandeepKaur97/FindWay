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
    var destination :CLLocationCoordinate2D?
    var pressed = false
    var count = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        

       let tapgesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
       tapgesture.numberOfTapsRequired = 2
       mapView.addGestureRecognizer(tapgesture)
            
            
        }
    @objc func doubleTapped(gesture: UIGestureRecognizer) {
          
          let alloverlays = mapView.overlays
          
          if alloverlays.count>0{
              mapView.removeOverlays(alloverlays)
          }
          
          count += 1
          pressed = true
          
          let allannotations = mapView.annotations

                        if allannotations.count > 1{
                            let ann = allannotations[1]
                            mapView.removeAnnotation(ann)
                        }

        let touchPoint = gesture.location(in: mapView)
               let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

               let annotation = MKPointAnnotation()
               annotation.coordinate = coordinate
               mapView.addAnnotation(annotation)
               
               destination = coordinate
               

}

}
