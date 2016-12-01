//
//  MapViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 11/4/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var place : Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        //mapView.showsTraffic = true
        mapView.showsCompass = true

        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(place.location) { [unowned self](placeMarks, error) in
            
            if error == nil {
                
                for placeMark in placeMarks! {
                    print(placeMark);
                    
                    let annotation = MKPointAnnotation();
                    annotation.title = self.place.name
                    annotation.subtitle = self.place.type
                    annotation.coordinate = (placeMark.location?.coordinate)!
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
                
            }else{
                print("ha habido un error: \(error?.localizedDescription)")
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if (annotation.isKind(of: MKUserLocation.self)){
            return nil
        }
        
        var annotationView : MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        imageView.image = UIImage(data: self.place.image as Data)
        
        annotationView?.leftCalloutAccessoryView = imageView
        
        annotationView?.pinTintColor = #colorLiteral(red: 0.1919409633, green: 0.4961107969, blue: 0.745100379, alpha: 1)
        
        return annotationView
    }
}
