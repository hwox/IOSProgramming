//
//  MapViewController.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 03/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000

    var houses : [House] = []

    override func viewDidLoad() {
        let initialLocation = CLLocation(latitude: 37.5384514, longitude:  127.0709764)
        // Do any additional setup after loading the view.
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        
        loadInitialData()
        
        mapView.addAnnotations(houses)
    }
    
    // 전송받은 posts 배열에서 정보를 얻어서 hospital 객체를 생성하고 배열에 추가 생성
    func loadInitialData(){
        for post in posts{
            let titleKorean = (post as AnyObject).value(forKey: "titleKorean") as! NSString as String
            print(titleKorean)
            let roadnameAddress = (post as AnyObject).value(forKey: "roadnameAddress") as! NSString as String
            print(roadnameAddress)
            let XPos = (post as AnyObject).value(forKey: "latitude") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "longitude") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let house = House(title: titleKorean, locationName: roadnameAddress, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            houses.append(house)
        }
    }
    

    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! House
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? House else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    @IBOutlet weak var mapView: MKMapView!
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
