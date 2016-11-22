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
    
    let chaparralHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238559, -118.527257),
        "topRight" : CLLocationCoordinate2DMake(34.238581, -118.526724),
        "bottomRight" : CLLocationCoordinate2DMake(34.237899, -118.526712),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237899, -118.527242)
    ]
    
    let citrusHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.239133, -118.528562),
        "topRight" : CLLocationCoordinate2DMake(34.239111, -118.527586),
        "bottomRight" : CLLocationCoordinate2DMake(34.238925, -118.527586),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238890, -118.528600)
    ]
    
    let cyprusHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.236700, -118.530094),
        "topRight" : CLLocationCoordinate2DMake(34.236695, -118.529259),
        "bottomRight" : CLLocationCoordinate2DMake(34.236020, -118.529262),
        "bottomLeft" : CLLocationCoordinate2DMake(34.236017, -118.530098)
    ]
    
    let eucalyptusHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238735, -118.528810),
        "topRight" : CLLocationCoordinate2DMake(34.238749, -118.527646),
        "bottomRight" : CLLocationCoordinate2DMake(34.238549, -118.527628),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238545, -118.528765)
    ]

    
    let jacarandaHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.24205889685744, -118.52944493293762),
        "topRight" : CLLocationCoordinate2DMake(34.24205889685744, -118.52781414985657),
        "bottomRight" : CLLocationCoordinate2DMake(34.241021196083864, -118.52781414985657),
        "bottomLeft" : CLLocationCoordinate2DMake(34.241021196083864, -118.52944493293762)
    ]
    
    let jeromerichfieldHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.239085, -118.530943),
        "topRight" : CLLocationCoordinate2DMake(34.239071, -118.530113),
        "bottomRight" : CLLocationCoordinate2DMake(34.238703, -118.530125),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238693, -118.530939)
    ]
    
    let juniperHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.242438, -118.530968),
        "topRight" : CLLocationCoordinate2DMake(34.241701, -118.530017),
        "bottomRight" : CLLocationCoordinate2DMake(34.241425, -118.530243),
        "bottomLeft" : CLLocationCoordinate2DMake(34.242115, -118.531083)
    ]
    
    let b5parkingStructure : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.2419081206163 , -118.53329658508301),
        "topRight" : CLLocationCoordinate2DMake(34.2419081206163 , -118.53190183639526),
        "bottomRight" : CLLocationCoordinate2DMake(34.24122518955382, -118.53190183639526),
        "bottomLeft" : CLLocationCoordinate2DMake(34.24122518955382, -118.53329658508301)
    ]
    
    let b3parkingStructure : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238886, -118.533697),
        "topRight" : CLLocationCoordinate2DMake(34.238917, -118.531892),
        "bottomRight" : CLLocationCoordinate2DMake(34.237433, -118.531855),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237423, -118.533653)
    ]
    
    let redwoodHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.242604, -118.527055),
        "topRight" : CLLocationCoordinate2DMake(34.242568, -118.525317),
        "bottomRight" : CLLocationCoordinate2DMake(34.241309, -118.525323),
        "bottomLeft" : CLLocationCoordinate2DMake(34.241282, -118.527018)
    ]
    
    let sequoiaHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.240787, -118.528441),
        "topRight" : CLLocationCoordinate2DMake(34.240777, -118.527617),
        "bottomRight" : CLLocationCoordinate2DMake(34.240136, -118.527581),
        "bottomLeft" : CLLocationCoordinate2DMake(34.240131, -118.528447)
    ]
    
    let sierraHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238445, -118.531383),
        "topRight" : CLLocationCoordinate2DMake(34.238445, -118.530037),
        "bottomRight" : CLLocationCoordinate2DMake(34.238105, -118.530034),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238099, -118.531392)
    ]

    let studentRecCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.2405954689889, -118.52519631385803),
        "topRight" : CLLocationCoordinate2DMake(34.2405954689889, -118.52465987205505),
        "bottomRight" : CLLocationCoordinate2DMake(34.2393448831962, -118.52465987205505),
        "bottomLeft" : CLLocationCoordinate2DMake(34.2393448831962, -118.52519631385803)
    ]
    
    let oviattLibrary : [String : CLLocationCoordinate2D] = [
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
    
    let liveoakHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238359, -118.528787),
        "topRight" : CLLocationCoordinate2DMake(34.238359, -118.527623),
        "bottomRight" : CLLocationCoordinate2DMake(34.238155, -118.527614),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238159, -118.528778)
    ]
    
    let manzanitaHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.237871, -118.530714),
        "topRight" : CLLocationCoordinate2DMake(34.237848, -118.529486),
        "bottomRight" : CLLocationCoordinate2DMake(34.236856, -118.529432),
        "bottomLeft" : CLLocationCoordinate2DMake(34.236855, -118.530640)
    ]
    
    let g3parkingStructure : [String: CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238933, -118.525656),
        "topRight" : CLLocationCoordinate2DMake(34.238961, -118.524635),
        "bottomRight" : CLLocationCoordinate2DMake(34.237362, -118.524630),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237389, -118.525652)
    ]
    
    let universityHall : [String: CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.240160, -118.532350),
        "topRight" : CLLocationCoordinate2DMake(34.240163, -118.531845),
        "bottomRight" : CLLocationCoordinate2DMake(34.239280, -118.531855),
        "bottomLeft" : CLLocationCoordinate2DMake(34.239274, -118.532343)
    ]
    
    let universityStudentUnion : [String: CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.240251, -118.527234),
        "topRight" : CLLocationCoordinate2DMake(34.240247, -118.526794),
        "bottomRight" : CLLocationCoordinate2DMake(34.239841, -118.526801),
        "bottomLeft" : CLLocationCoordinate2DMake(34.239842, -118.527244)
    ]
    
    let valleyPerformingArtsCenter : [String: CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.236655, -118.528721),
        "topRight" : CLLocationCoordinate2DMake(34.236626, -118.527525),
        "bottomRight" : CLLocationCoordinate2DMake(34.235838, -118.527565),
        "bottomLeft" : CLLocationCoordinate2DMake(34.235764, -118.528778)
    ]

    init() {
        locations["Bayrahmian Hall"] = bayrahmianHall
        locations["B3 Parking Structure"] = b3parkingStructure
        locations["B5 Parking Structure"] = b5parkingStructure
        locations["Chaparral Hall"] = chaparralHall
        locations["Citrus Hall"] = citrusHall
        locations["Cyprus Hall"] = cyprusHall
        locations["Eucalyptus Hall"] = eucalyptusHall
        locations["G3 Parking Structure"] = g3parkingStructure
        locations["Jacaranda Hall"] = jacarandaHall
        locations["Jerome Richfield Hall"] = jeromerichfieldHall
        locations["Juniper Hall"] = juniperHall
        locations["Live Oak Hall"] = liveoakHall
        locations["Matador Book Store"] = bookStore
        locations["Manzanita Hall"] = manzanitaHall
        locations["Oviatt Library"] = oviattLibrary
        locations["Redwood Hall/Matadome"] = redwoodHall
        locations["Sequoia Hall"] = sequoiaHall
        locations["Sierra Hall"] = sierraHall
        locations["Student Rec Center"] = studentRecCenter
        locations["University Hall"] = universityHall
        locations["USU"] = universityStudentUnion
        locations["VPAC"] = valleyPerformingArtsCenter
    }
    
}
