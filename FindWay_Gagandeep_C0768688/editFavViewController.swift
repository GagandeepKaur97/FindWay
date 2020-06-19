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
    let defaults1 = UserDefaults.standard
    var latitude: Double = UserDefaults.standard.double(forKey: "latitude")
     var longitude: Double = UserDefaults.standard.double(forKey: "longitude")
   var lat : Double?
     var long : Double?
     var street : String?
     var city : String?
    var location_index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        mapview.delegate = self
        print("view did load")
        print(location_index)
        print(Favplaces.fpArray[0].lat)
        print(Favplaces.fpArray[0].long)
        print(Favplaces.fpArray[0].street)
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
   
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
    
    
        print("-----")
        print(view.annotation?.coordinate)
        print("-----")
        getAddress(ann: view.annotation as! MKPointAnnotation)
        
        
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
            print("updated location----\n")
                    print(getAddress(ann: annotation as! MKPointAnnotation))
               
                          return pin
           
    }
    
   func getAddress( ann: MKPointAnnotation) {
    let location = CLLocation(latitude: ann.coordinate.latitude, longitude: ann.coordinate.longitude)
    
   
    
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
                    
                    
                    print("updated array")
                    print(self.location_index)
                    print(Favplaces.fpArray[0].lat)
                    print(Favplaces.fpArray[0].long)
                    print(Favplaces.fpArray[0].street)
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
                    
                    
                    print(address)
                    print("---debugging---")
                    print(placemark.administrativeArea)
                    print(placemark.country)
                    print(placemark.location)
                    print(placemark.locality)
                    print(placemark.subLocality)
                    print(placemark.subThoroughfare)
                    print(placemark.thoroughfare)
                    
//                 self.defaults1.setValue(address, forKey: "city")
                }
                ann.title = address
                self.city = address
                Favplaces.fpArray[self.location_index].city = self.city!
                Favplaces.fpArray[self.location_index].lat = Double(location.coordinate.latitude)
                Favplaces.fpArray[self.location_index].long = Double(location.coordinate.longitude)
                
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
                 
                 
                 
                 self.defaults1.set(temp_lat, forKey: "lat")
                 self.defaults1.set(temp_long, forKey: "long")
                 self.defaults1.set(temp_street, forKey: "street")
                 self.defaults1.set(temp_city, forKey: "city")

            
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
