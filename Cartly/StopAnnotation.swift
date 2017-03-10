//
//  StopAnnotation.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 3/1/17.
//  Copyright © 2017 Revenge Apps Inc. All rights reserved.
//


import UIKit
import MapKit

class StopAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var name: String
    var direction: String
    var image : UIImage
    var numPeopleWaiting : Int
    
    init (coordinate: CLLocationCoordinate2D, name: String, direction: String, image: UIImage, numPeopleWaiting: Int){
        self.coordinate = coordinate
        self.name = name
        self.direction = direction
        self.image = image
        self.numPeopleWaiting = numPeopleWaiting
    }
}
