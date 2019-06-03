//

//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import UIKit
import MapKit
import Foundation
class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    
    let regionRadius : CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var houses : [House] = []
    
    func loadInitialData() {
        for post in posts {
            let titleKorean = (post as AnyObject).value(forKey: "titleKorean") as! NSString as String
            let roadnameAddress = (post as AnyObject).value(forKey: "roadnameAddress") as! NSString as String
            let latitude = (post as AnyObject).value(forKey: "latitude") as! NSString as String
            let longitude = (post as AnyObject).value(forKey: "longitude") as! NSString as String
            let lat = (latitude as NSString).doubleValue
            let lon = (longitude as NSString).doubleValue
            let house = House(title: titleKorean, locationName: roadnameAddress, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            houses.append(house)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! House
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? House else { return nil}
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.5384514, longitude: 127.0709764)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(houses)
    }
}
