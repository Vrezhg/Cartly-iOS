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
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var driverOnlineSwitch: UISwitch!
    @IBOutlet weak var rideRequestView: UIView!
    @IBOutlet weak var rideInfoLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var start : CLLocationCoordinate2D!
    var end : CLLocationCoordinate2D!
    
    var annotations : [MKAnnotation] = []
    var path : MKRoute?
    
    let pickupLocation = PickupLocations()
    let promptMessages = ["Doubletap a pickup location..", "Doubletap a dropoff location"]
    
    var databaseRef = FIRDatabase.database().reference()
    let currentUser = FIRAuth.auth()?.currentUser
    
    var driverMode = false
    var userRequestId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self

        let csunLocation = CLLocation(latitude: 34.238476, longitude: -118.529330)
        
        if driverMode {
            //hide appropriate labels and functionality
            driverOnlineSwitch.isEnabled = true
            driverOnlineSwitch.setOn(true, animated: true)
            promptLabel.text = "Waiting for requests..."
            databaseRef.child("Requests").observe(.childAdded , with: { (snapshot) in
                
                DispatchQueue.main.async {
                    print("request received")
                    self.rideRequestView.isHidden = false
                }
                if let requestDetails = snapshot.value as? [String : AnyObject] {
                    self.userRequestId = requestDetails["user"] as? String
                    if let from = requestDetails["from"] as? String, let to = requestDetails["to"] as? String, let latitude = requestDetails["latitude"] as? String, let longitude = requestDetails["longitude"] as? String{
                    self.promptLabel.text = "Request received!"
                    self.rideInfoLabel.text = "Needs a ride from \(from) to \(to)"
                    self.riderLocation = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
                    }
                }
            })
        } else {
            promptLabel.text = promptMessages[0]
        }
        
        mapView.mapType = MKMapType.satellite
        mapView.isZoomEnabled = false
        typeSelector.selectedSegmentIndex = 1
        
        centerOnUser(location: csunLocation)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //checks when trip is accepted
        databaseRef.child("Enroute").observe(.childAdded , with: {
            (snapshot) in
            if let newRideDetails = snapshot.value as? [String : AnyObject] {
                // someone accepted the ride request
                if let rider = newRideDetails["rider"] as? String {
                    if let currentUser = FIRAuth.auth()?.currentUser{
                        if rider == currentUser.uid {
                            let alert = self.basicDestructiveAlert(title: "Success!", message: "Your carty is on the way!", style: .alert)
                            if self.driverMode == false {
                                DispatchQueue.main.async {
                                    self.promptLabel.text = "Your carty is arriving soon"
                                    self.promptView.isHidden = false
                                    self.present(alert, animated: true, completion: nil)
                                    print("Start : \(self.start) End: \(self.end)")
                                    if let from = self.start, let to = self.end {
                                        self.getDirections(from: from , to: to)
                                    }
                                }
                            }
                            self.progressIndicator.stopAnimating()
                            self.progressView.isHidden = true
                        } else {
                            print("Not my request, rider: \(rider) driver: \(currentUser.uid)")
                        }
                    }
                }
            }
        })
    }
    
    var riderLocation :CLLocationCoordinate2D?
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        <#code#>
    }
   
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        sender.numberOfTapsRequired = 2
        let touchPoint = sender.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        checkWhereTapped(tapped: touchMapCoordinate)

    }
    @IBAction func acceptRide(_ sender: UIButton) {
        rideRequestView.isHidden = true
        if let user = currentUser, let requestUserId = userRequestId {
            let acceptRequest : [AnyHashable : Any] = [AnyHashable("driver") : user.uid, AnyHashable("rider") : requestUserId]
            databaseRef.child("Enroute").child(requestUserId).updateChildValues(acceptRequest)
            promptLabel.text = "Proceed to pickup location"
            if let location = locationManager.location, let to = riderLocation {
                self.getDirections(from: location.coordinate, to: to)
            }
        }

    }
    @IBAction func declineRide(_ sender: UIButton) {
        rideRequestView.isHidden = true
    }
    
    func checkWhereTapped(tapped: CLLocationCoordinate2D) {
        if driverMode == false {
            var buildingTitle = ""
            
            //iterates through building coordinates and checks whether its within bounds
            for (key, value) in  pickupLocation.locations {
                if let topLeft = value["topLeft"] , let topRight = value["topRight"], let bottomRight = value["bottomRight"], let bottomLeft = value["bottomLeft"] {
                    if (tapped.latitude <= topLeft.latitude && tapped.latitude >= bottomRight.latitude && tapped.longitude <= topRight.longitude && tapped.longitude >= bottomLeft.longitude) {
                        
                        buildingTitle = key
                        break
                    }
                }
            }
            
            if buildingTitle != "" {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = tapped
            pointAnnotation.title = buildingTitle
            
            annotations.append(pointAnnotation)
            mapView.addAnnotation(pointAnnotation)
                
            if start == nil {
                start = tapped
                promptLabel.text = promptMessages[1]
            } else {
                end = tapped
                promptView.isHidden = true
                if let from = annotations[0].title{
                    let message = "From: \(from!)\nTo: \(buildingTitle)"
                    let alert = UIAlertController(title: "Make request?", message: message, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: {
                        (action) in
                        
                    })
                    let confirm = UIAlertAction(title: "Confirm", style: .default, handler: {
                        (action) in
                        self.addTripRequest(from: from! ,to: buildingTitle)
                    })
                    alert.addAction(cancel)
                    alert.addAction(confirm)
                    present(alert, animated: true, completion: nil)
                }
                //getDirections(from: start, to: end)
                resetButton.isHidden = false
            }
                
            }
        }
    }
    
    @IBAction func resetRoute(_ sender: Any) {
        mapView.removeAnnotations(annotations)
        //mapView.remove((path?.polyline)!)
        start = nil
        end = nil
        promptLabel.text = promptMessages[0]
        promptView.isHidden = false
        
        resetButton.isHidden = true
    }
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    
    func addTripRequest(from : String, to : String){
        
        if let user = currentUser{
            progressView.isHidden = false
            progressIndicator.startAnimating()
            
            var requestDetails : [AnyHashable : Any] = [AnyHashable("from")  : from, AnyHashable("to") : to, AnyHashable("user") : user.uid]
            if let location = locationManager.location{
                requestDetails["latitude"] = String(location.coordinate.latitude)
                requestDetails["longitude"] = String(location.coordinate.longitude)
            }
            // add to requests
            databaseRef.child("Requests").child(user.uid).updateChildValues(requestDetails, withCompletionBlock: { (error, reference) in
                if (error == nil) {
                } else {
                    if let errorDescription = error?.localizedDescription{
                        print(errorDescription)
                    }
                }
            })

        } else {
            let alert = basicDestructiveAlert(title: "No user logged in", message: "please login", style: .alert)
            self.present( alert, animated: true, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let path = MKPolylineRenderer(overlay: overlay)
        path.strokeColor = UIColor.red
        path.lineWidth = 2.0
        
        return path
    }
    
    func getDirections(from : CLLocationCoordinate2D, to : CLLocationCoordinate2D){
        let directions = MKDirectionsRequest()
        let start = MKPlacemark(coordinate: from)
        let end = MKPlacemark(coordinate: to)
        directions.source = MKMapItem(placemark: start)
        directions.destination = MKMapItem(placemark: end)
        directions.transportType = MKDirectionsTransportType.walking
        
        let route = MKDirections(request: directions)
        route.calculate(completionHandler: {
            (response, error) in
            
            if let route = response?.routes{
                self.path = route.first
            
                self.mapView.add((self.path?.polyline)!, level: MKOverlayLevel.aboveRoads)
                self.mapView.setNeedsDisplay()
            } else {
                print("no routes")
            }
            
        })
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

