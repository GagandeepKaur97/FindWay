//
//  AddPlaceVC.swift
//  FindWay_Gagandeep_C0768688
//
//  Created by Gagan on 2020-06-14.
//  Copyright © 2020 Gagan. All rights reserved.
//

import UIKit
import MapKit

class AddPlaceVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
     var locationManager = CLLocationManager()
    

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
        
        
        let allannotations = mapView.annotations

        if allannotations.count > 1{
            
            
            let ann = allannotations[1]
            mapView.removeAnnotation(ann)
        }
              
              let touchPoint = gesture.location(in: mapView)
              let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

              let annotation = MKPointAnnotation()
              annotation.coordinate = coordinate

        annotation.title = "hello"
        mapView.addAnnotation(annotation)
                   

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            print("view for anoo//////////")

            return nil
        }
        else{
            print("view for anoo...............")
            let av = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            av.image = UIImage(named: "customIcon")
            
            av.canShowCallout = true
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return av
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alert = UIAlertController(title: "Favourites", message: "Do you want to add this place to favourite!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            print("............add")
        }
        
        let noAction = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
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
