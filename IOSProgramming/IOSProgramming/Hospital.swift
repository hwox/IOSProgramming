//
//  Hospital.swift
//  HospitalMap
//
//  Created by KPU_GAME on 22/04/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import Foundation
import MapKit
import Contacts
class Hospital: NSObject, MKAnnotation {
    
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
    // 클래스에 추가하는 helper 메소드
    // MKPlacemark로 부터 MKMapItem을 생성
    // Info button을 누르면 MKMapItem을 오픈하게 된다.
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
