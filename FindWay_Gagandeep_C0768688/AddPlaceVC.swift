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
    
    var lat : Double?
    var long : Double?
    var street : String?
    var city : String?
    var defaults : UserDefaults?
    let defaults1 = UserDefaults.standard
    

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
    
        
    

        mapView.addAnnotation(annotation)
        lat = coordinate.latitude
        long = coordinate.longitude
        getAddress(ann: annotation)
                   

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
            getAddress(ann: annotation as! MKPointAnnotation)
            return av
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
        let alert = UIAlertController(title: "Favourites", message: "Do you want to add this place to favourite!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            self.defaults = UserDefaults.standard
            let fp = Favplaces(lat: self.lat!, long: self.long!, street: self.street!, city: self.city!)
            Favplaces.fpArray.append(fp)
            
//            self.defaults?.set(Favplaces.fpArray, forKey: "SavedArray")
            
           
            print("............add")
        }
        
        let noAction = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    func getAddress( ann: MKPointAnnotation) {
        let location = CLLocation(latitude: lat!, longitude: long!)
        
       
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error)
            } else {
                if let placemark = placemarks?[0] {

                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                        
                        
                    }

                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare!
                        
                        ann.title = address
                        self.street = address
                        self.defaults1.setValue(address, forKey: "street")
                        address = ""
                    }

                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + " "
                    }

                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + " "
                    }

                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + " "
                    }

                    if placemark.country != nil {
                        address += placemark.country!
                        
                        ann.subtitle = address
                        self.city = address
                     self.defaults1.setValue(address, forKey: "city")
                    }

                
                }
            }


        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }}*/
     @IBAction func zoomIn(_ sender: UIButton) {
        var zoomRegion = mapView.region
                     zoomRegion.span.latitudeDelta = zoomRegion.span.latitudeDelta/2
                     zoomRegion.span.longitudeDelta = zoomRegion.span.longitudeDelta/2
                     mapView.setRegion(zoomRegion, animated: true)
     
    }

    @IBAction func zoomOut(_ sender: UIButton) {
        var zoomRegion = mapView.region
        zoomRegion.span.latitudeDelta = zoomRegion.span.latitudeDelta*2
        zoomRegion.span.longitudeDelta = zoomRegion.span.longitudeDelta*2
        mapView.setRegion(zoomRegion, animated: true)
        
    }

}
