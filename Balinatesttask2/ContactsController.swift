//
//  ContactsController.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ContactsController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 100
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        showPlacemarks()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }
    
    func showPlacemarks() {
        
        let first_cafe_adress = CLLocationCoordinate2D(latitude: 53.922256, longitude: 27.596691)
        let second_cafe_adress = CLLocationCoordinate2D(latitude: 53.926780, longitude: 27.594459)
        let third_cafe_adress = CLLocationCoordinate2D(latitude: 53.936161, longitude: 27.481999)
        
        let first_cafe_Placemark = MKPlacemark(coordinate: first_cafe_adress, addressDictionary: nil)
        let second_cafe_Placemark = MKPlacemark(coordinate: second_cafe_adress, addressDictionary: nil)
        let third_cafe_Placemark = MKPlacemark(coordinate: third_cafe_adress, addressDictionary: nil)
        
        let first_cafe_Annotation = MKPointAnnotation()
        first_cafe_Annotation.title = "Farfor, м.Академия Наук"
        if let location = first_cafe_Placemark.location {
            first_cafe_Annotation.coordinate = location.coordinate
        }
        
        let second_cafe_Annotation = MKPointAnnotation()
        second_cafe_Annotation.title = "Farfor, Я.Коласа 39"
        if let location = second_cafe_Placemark.location {
            second_cafe_Annotation.coordinate = location.coordinate
        }
        
        let third_cafe_Annotation = MKPointAnnotation()
        third_cafe_Annotation.title = "Farfor, пр-т Победителей, Минск-Арена"
        if let location = third_cafe_Placemark.location {
            third_cafe_Annotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([first_cafe_Annotation,second_cafe_Annotation,third_cafe_Annotation], animated: true )
    }
}
