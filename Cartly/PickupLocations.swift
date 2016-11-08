//
//  PickupLocations.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 11/7/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import CoreLocation

class PickupLocations {
    
    var locations : [String : [String: CLLocationCoordinate2D]] = [:]
    
    let bayrahmianHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.240684162311304, -118.53145122528076),
        "topRight" : CLLocationCoordinate2DMake(34.240684162311304, -118.53015303611755),
        "bottomRight" : CLLocationCoordinate2DMake(34.239912527277056, -118.53015303611755),
        "bottomLeft" : CLLocationCoordinate2DMake(34.239912527277056, -118.53145122528076)
    ]
    
    
    let jacarandaHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.24205889685744, -118.52944493293762),
        "topRight" : CLLocationCoordinate2DMake(34.24205889685744, -118.52781414985657),
        "bottomRight" : CLLocationCoordinate2DMake(34.241021196083864, -118.52781414985657),
        "bottomLeft" : CLLocationCoordinate2DMake(34.241021196083864, -118.52944493293762)
        ]
    
    let b5Parking : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.2419081206163 , -118.53329658508301),
        "topRight" : CLLocationCoordinate2DMake(34.2419081206163 , -118.53190183639526),
        "bottomRight" : CLLocationCoordinate2DMake(34.24122518955382, -118.53190183639526),
        "bottomLeft" : CLLocationCoordinate2DMake(34.24122518955382, -118.53329658508301)
        ]
    
    let b3Parking : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238886, -118.533697),
        "topRight" : CLLocationCoordinate2DMake(34.238917, -118.531892),
        "bottomRight" : CLLocationCoordinate2DMake(34.237433, -118.531855),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237423, -118.533653)
    ]

    let studentRecCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.2405954689889, -118.52519631385803),
        "topRight" : CLLocationCoordinate2DMake(34.2405954689889, -118.52465987205505),
        "bottomRight" : CLLocationCoordinate2DMake(34.2393448831962, -118.52465987205505),
        "bottomLeft" : CLLocationCoordinate2DMake(34.2393448831962, -118.52519631385803)
        ]
    
    let oviatLibrary : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.24038260463415, -118.53000283241272),
        "topRight" : CLLocationCoordinate2DMake(34.24038260463415, -118.52861881256104),
        "bottomRight" : CLLocationCoordinate2DMake(34.23967305289722, -118.52861881256104),
        "bottomLeft" : CLLocationCoordinate2DMake(34.23967305289722, -118.53000283241272)
        ]
    
    let bookStore : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.237767, -118.528656),
        "topRight" : CLLocationCoordinate2DMake(34.237754, -118.527664),
        "bottomRight" : CLLocationCoordinate2DMake(34.237013, -118.527651),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237022, -118.528694)
        ]
    
    let manzanitaHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.237871, -118.530714),
        "topRight" : CLLocationCoordinate2DMake(34.237848, -118.529486),
        "bottomRight" : CLLocationCoordinate2DMake(34.236856, -118.529432),
        "bottomLeft" : CLLocationCoordinate2DMake(34.236855, -118.530640)
    ]

    init() {
        locations["Bayrahmian Hall"] = bayrahmianHall
        locations["Jacaranda Hall"] = jacarandaHall
        locations["B5 Parking"] = b5Parking
        locations["B3 Parking"] = b3Parking
        locations["Manzanita Hall"] = manzanitaHall
        locations["Book Store"] = bookStore
        locations["Student Rec Center"] = studentRecCenter
        locations["Oviat Library"] = oviatLibrary
    }
    
}
