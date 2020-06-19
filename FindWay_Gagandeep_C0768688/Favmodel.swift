//
//  Favmodel.swift
//  FindWay_Gagandeep_C0768688
//
//  Created by Gagan on 2020-06-14.
//  Copyright © 2020 Gagan. All rights reserved.
//

import Foundation
class Favplaces
{
    internal init(lat: Double, long: Double, street: String, city: String) {
        self.lat = lat
        self.long = long
        self.street = street
        self.city = city
    }
    
    var lat : Double
    var long : Double
    var street : String
    var city : String
    
    static var fpArray = [Favplaces]()
    
    // store data in user defaults
    
    //lat
    //long
    //street
    //city
    
}
