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
   var lat : Double?
     var long : Double?
     var street : String?
     var city : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        mapview.delegate = self
        
           notesSaveLocation()
    }
    
    func notesSaveLocation(){


        let favplace = MKPointAnnotation()
         favplace.title = "favplace"
         favplace.coordinate = CLLocationCoordinate2D(latitude: latitude ,longitude: longitude)
        let newp = CLLocationCoordinate2D(latitude: latitude ,longitude: longitude)
        let latDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)

        let regionSpan =   MKCoordinateRegion(center: newp , span: span )
       
         mapview.addAnnotation(favplace)
        
            mapview.setRegion(regionSpan, animated: true)
         
          
      }
   
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
           
            
                    let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                        pin.image = UIImage(named: "customIcon")
                        pin.isDraggable = true
                          pin.pinTintColor = .red
                          pin.animatesDrop = true
                       pin.canShowCallout = true
                    pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                  lat = latitude
                           long = longitude
                       
                  getAddress(ann: annotation as! MKPointAnnotation)
                    print(getAddress(ann: annotation as! MKPointAnnotation))
               
                          return pin
           
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
                    UserDefaults.standard.setValue(address, forKey: "street")
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
                    print(address)
//                 self.defaults1.setValue(address, forKey: "city")
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
    }
    */

}
