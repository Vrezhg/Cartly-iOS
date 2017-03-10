//
//  ViewController.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 10/10/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase

class MapViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var driverOnlineSwitch: UISwitch!
    @IBOutlet weak var legendView: UIView!
    
    var locationManager: CLLocationManager!
    
    var databaseRef = FIRDatabase.database().reference()
    let currentUser = FIRAuth.auth()?.currentUser
    
    var driverMode = false
    var userRequestId : String?
    
    let locations = PickupLocations()
    let constants = Constants()
    var queue : [String : UInt] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self
        
        legendView.layer.cornerRadius = 10
        legendView.clipsToBounds = true
        
        let csunLocation = CLLocation(latitude: 34.238476, longitude: -118.529330)
        
        if driverMode {
            //hide appropriate labels and functionality
            driverOnlineSwitch.isEnabled = true
            driverOnlineSwitch.setOn(true, animated: true)
        } else {
           
        }
        
        mapView.mapType = MKMapType.standard
        typeSelector.selectedSegmentIndex = 0
        
        centerOnUser(location: csunLocation)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        for location in locations.clockwise {
            let annotation = StopAnnotation(coordinate: location.value, name: location.key, direction: "counterClockwise", image: UIImage(named: "\(location.key)Red")!, numPeopleWaiting: 0)
            mapView.addAnnotation(annotation)
        }
        
        for location in locations.counterClockwise {
            let annotation = StopAnnotation(coordinate: location.value, name: location.key, direction: "clockwise", image: UIImage(named: "\(location.key)Green")!, numPeopleWaiting: 0)
            mapView.addAnnotation(annotation)
        }
        
        
        let clockwisePath = MKPolyline(coordinates: locations.redPath, count: locations.redPath.count)
        let counterClockwisePath = MKPolyline(coordinates: locations.greenPath, count: locations.greenPath.count)
        
        mapView.addOverlays([clockwisePath,counterClockwisePath])
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setQueue()
        getCurrentQueues()
        setupDatabaseListeners()
    }
    
//    nhClock: UInt,nhCounter: UInt, unClock: UInt, unCounter: UInt, euClock: UInt, euCounter: UInt, jdClock: UInt, jdCounter: UInt, csClock: UInt, csCounter: UInt,vpacClock: UInt,vpacCounter: UInt
    func setQueue(){
        
        queue[constants.nhClock] = 0
        queue[constants.nhCounter] = 0
        queue[constants.unClock] = 0
        queue[constants.unCounter] = 0
        queue[constants.euClock] = 0
        queue[constants.euCounter] = 0
        queue[constants.jdClock] = 0
        queue[constants.jdCounter] = 0
        queue[constants.csClock] = 0
        queue[constants.csCounter] = 0
        queue[constants.vpacClock] = 0
        queue[constants.vpacCounter] = 0
    }
    
    func getCurrentQueues(){
        
        databaseRef.child(constants.queue).child(constants.nhClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.nhClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.nhCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.nhCounter] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.unClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.unClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.unCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.unCounter] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.euClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.euClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.euCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.euCounter] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.jdClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.jdClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.jdCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.jdCounter] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.csClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.csClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.csCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.csCounter] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.vpacClock).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.vpacClock] = people.childrenCount
        })
        databaseRef.child(constants.queue).child(constants.vpacCounter).observeSingleEvent(of: .value, with: { (people) in
            self.queue[self.constants.vpacCounter] = people.childrenCount
        })
    }
    
    func setupDatabaseListeners(){
        databaseRef.child(constants.queue).observe(.childAdded, with: { (people) in
            self.getCurrentQueues()
        })
        databaseRef.child(constants.queue).observe(.childRemoved, with: { (people) in
            self.getCurrentQueues()
        })
        databaseRef.child(constants.queue).observe(.childChanged, with: { (people) in
            self.getCurrentQueues()
        })
    }
    
    var queueKey = ""
    
    func addTripRequest(name : String){
        
        if let user = currentUser{
            let key = databaseRef.child(name).childByAutoId().key
            //queuekey = "\(key)"
            databaseRef.child(constants.queue).child(name).child(key).setValue(user.uid)
        } else {
            let alert = basicDestructiveAlert(title: "No user logged in", message: "please login", style: .alert)
            self.present( alert, animated: true, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation") as MKAnnotationView!
        
        if let stopAnnotation = annotation as? StopAnnotation{
            
            if (annotationView == nil) {
                annotationView = MKAnnotationView(annotation: stopAnnotation, reuseIdentifier: "Custom Annotation")
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = stopAnnotation;
            }
            
            annotationView?.image = stopAnnotation.image
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let stopAnnotation = view.annotation as? StopAnnotation{

            let views = Bundle.main.loadNibNamed("Stop", owner: nil, options: nil)
            let calloutView = views?[0] as! Stop
            calloutView.stopName.text = stopAnnotation.name
            calloutView.direction.image = UIImage(named: stopAnnotation.direction)!
            calloutView.ridersWaiting.text = "\(queue["\(stopAnnotation.name)-\(stopAnnotation.direction)"]!)"
            calloutView.layer.cornerRadius = 10
            calloutView.clipsToBounds = true
            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.22)
            view.addSubview(calloutView)
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        }

    }
    var touchLocation : CGPoint = CGPoint()

    @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
        sender.numberOfTapsRequired = 1
        touchLocation = sender.location(in: self.view)
        self.dismissKeyboard()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self)
        {
            for subview in view.subviews
            {
                if let calloutView = subview as? Stop{
                    let annotationLocation = mapView.convert(view.annotation!.coordinate, toPointTo: self.view)
                    
                    // create a rect which is equal to size of BusinessCalloutView
                    let touchRectOrigin = CGPoint(x: annotationLocation.x - calloutView.bounds.width/2 , y: annotationLocation.y - (calloutView.bounds.height*1.5))
                    let touchRect = CGRect(origin: touchRectOrigin, size: calloutView.bounds.size)
                    
                    if touchRect.contains(touchLocation) {
                        if let annotation = view.annotation as? StopAnnotation{
                            if annotation.direction == "clockwise"{
                                addTripRequest(name: "\(annotation.name)-clockwise")
                            } else {
                                addTripRequest(name: "\(annotation.name)-counterClockwise")
                            }
                        }
                    }
                }
                
                subview.removeFromSuperview()
            }
        }
    }
    
    var count = 0
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let path = MKPolylineRenderer(overlay: overlay)
        
        if count == 0 {
            path.strokeColor = UIColor.red
            count += 1
        } else {
            path.strokeColor = UIColor.green
        }
        
        path.lineWidth = 2.5
        
        return path
    }

    @IBAction func zoomToCurrentLocation(_ sender: UIBarButtonItem) {
        if let location = locationManager.location{
            centerOnUser(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerOnUser(location: locations.first!)
    }
    
    func centerOnUser (location : CLLocation){
        
        let spanX = 0.005
        let spanY = 0.005
        var region : MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = location.coordinate.latitude
        region.center.longitude = location.coordinate.longitude
        region.span.latitudeDelta = spanX
        region.span.longitudeDelta = spanY
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func setMapType(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapType.standard
            break
        case 1:
            mapView.mapType = MKMapType.satellite
            break
        case 2:
            mapView.mapType = MKMapType.hybrid
            break
        default:
            break
        }
    }

}

