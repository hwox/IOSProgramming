//
//  House.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 03/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import Foundation
import MapKit

import Contacts


class House: NSObject, MKAnnotation {
    
    let title: String?

    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}

