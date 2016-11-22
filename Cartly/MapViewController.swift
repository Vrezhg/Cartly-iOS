//
//  ViewController.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 10/10/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    var locationManager: CLLocationManager!
    var start : CLLocationCoordinate2D!
    var end : CLLocationCoordinate2D!
    
    var annotations : [MKAnnotation] = []
    var path : MKRoute?
    
    let pickupLocation = PickupLocations()
    let promptMessages = ["Select a pickup location..", "Select a dropoff location"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self

        let csunLocation = CLLocation(latitude: 34.238476, longitude: -118.529330)
        
        mapView.mapType = MKMapType.satellite
        mapView.isZoomEnabled = false
        typeSelector.selectedSegmentIndex = 1
        
        centerOnUser(location: csunLocation)
        
        promptLabel.text = promptMessages[0]
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
   
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        sender.numberOfTapsRequired = 1
        let touchPoint = sender.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        checkWhereTapped(tapped: touchMapCoordinate)

    }
    
    func checkWhereTapped(tapped: CLLocationCoordinate2D) {
        
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
            getDirections(from: start, to: end)
            resetButton.isHidden = false
        }
            
        }
    }
    
    @IBAction func resetRoute(_ sender: Any) {
        mapView.removeAnnotations(annotations)
        mapView.remove((path?.polyline)!)
        promptLabel.text = promptMessages[0]
        promptView.isHidden = false
        
        resetButton.isHidden = true
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
                
                let alert = UIAlertController(title: "Success", message: "Your Carty will arrive in 3 min.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive , handler: nil))
                self.present(alert, animated: true, completion: nil)
                
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

