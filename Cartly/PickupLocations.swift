//
//  PickupLocations.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 11/7/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

/*
 let addieKlotzStudentHealthCenter : [String : CLLocationCoordinate2D] = [
 "topLeft" :
 "topRight" :
 "bottomRight" :
 "bottomLeft" :
 ]
 */

import UIKit
import CoreLocation

class PickupLocations {
    
    var locations : [String : [String: CLLocationCoordinate2D]] = [:]
    var clockwise : [String : CLLocationCoordinate2D] = [:]
    var counterClockwise : [String : CLLocationCoordinate2D] = [:]
    var parking : [String : CLLocationCoordinate2D] = [:]

    
    let artAndDesignCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.243924, -118.530353),
        "topRight" : CLLocationCoordinate2DMake(34.243927, -118.529596),
        "bottomRight" : CLLocationCoordinate2DMake(34.243135, -118.529734),
        "bottomLeft" : CLLocationCoordinate2DMake(34.243130, -118.529987)
    ]
    
    //may have to fix coordinates for Arbor Court to not conflict with arbor grill & freudian sip
    let arborCourt : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.241412, -118.530079),
        "topRight" : CLLocationCoordinate2DMake(34.241408, -118.529551),
        "bottomRight" : CLLocationCoordinate2DMake(34.240948, -118.529560),
        "bottomLeft" : CLLocationCoordinate2DMake(34.240955, -118.530059)
    ]
    
    let athleticsOfficeBuilding : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.241735, -118.525563),
        "topRight" : CLLocationCoordinate2DMake(34.241728, -118.525345),
        "bottomRight" : CLLocationCoordinate2DMake(34.241521, -118.525347),
        "bottomLeft" : CLLocationCoordinate2DMake(34.241514, -118.525491)
    ]
    
    let bayramianHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.240684162311304, -118.53145122528076),
        "topRight" : CLLocationCoordinate2DMake(34.240684162311304, -118.53015303611755),
        "bottomRight" : CLLocationCoordinate2DMake(34.239912527277056, -118.53015303611755),
        "bottomLeft" : CLLocationCoordinate2DMake(34.239912527277056, -118.53145122528076)
    ]
    
    let brownCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.242636, -118.527031),
        "topRight" : CLLocationCoordinate2DMake(34.242561, -118.526196),
        "bottomRight" : CLLocationCoordinate2DMake(34.242372, -118.526200),
        "bottomLeft" : CLLocationCoordinate2DMake(34.242313, -118.526961)
    ]
    
    let centralPlant : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.243354, -118.530809),
        "topRight" : CLLocationCoordinate2DMake(34.243348, -118.530362),
        "bottomRight" : CLLocationCoordinate2DMake(34.242918, -118.530366),
        "bottomLeft" : CLLocationCoordinate2DMake(34.242912, -118.530809)
    ]
    
    let chaparralHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238559, -118.527257),
        "topRight" : CLLocationCoordinate2DMake(34.238581, -118.526724),
        "bottomRight" : CLLocationCoordinate2DMake(34.237899, -118.526712),
        "bottomLeft" : CLLocationCoordinate2DMake(34.237899, -118.527242)
    ]
    
    let chicanoHouse : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.242545, -118.530045),
        "topRight" : CLLocationCoordinate2DMake(34.242540, -118.529869),
        "bottomRight" : CLLocationCoordinate2DMake(34.242300, -118.529903),
        "bottomLeft" : CLLocationCoordinate2DMake(34.242295, -118.530027)
    ]
    
    let childrensCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.243508, -118.533530),
        "topRight" : CLLocationCoordinate2DMake(34.243501, -118.533183),
        "bottomRight" : CLLocationCoordinate2DMake(34.242945, -118.533147),
        "bottomLeft" : CLLocationCoordinate2DMake(34.242955, -118.533558)
    ]
    
    let citrusHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.239133, -118.528562),
        "topRight" : CLLocationCoordinate2DMake(34.239111, -118.527586),
        "bottomRight" : CLLocationCoordinate2DMake(34.238925, -118.527586),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238890, -118.528600)
    ]
    
    let cypressHall : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.236700, -118.530094),
        "topRight" : CLLocationCoordinate2DMake(34.236695, -118.529259),
        "bottomRight" : CLLocationCoordinate2DMake(34.236020, -118.529262),
        "bottomLeft" : CLLocationCoordinate2DMake(34.236017, -118.530098)
    ]
    
    let donaldBianchiPlanetarium : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.239119, -118.528557),
        "topRight" : CLLocationCoordinate2DMake(34.239120, -118.528375),
        "bottomRight" : CLLocationCoordinate2DMake(34.238981, -118.528373),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238981, -118.528555)
    ]
    
    let duckPond : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.236728, -118.526253),
        "topRight" : CLLocationCoordinate2DMake(34.236722, -118.525864),
        "bottomRight" : CLLocationCoordinate2DMake(34.236493, -118.525869),
        "bottomLeft" : CLLocationCoordinate2DMake(34.236499, -118.526249)
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
    
    let klotzStudentHealthCenter : [String : CLLocationCoordinate2D] = [
        "topLeft" : CLLocationCoordinate2DMake(34.238274, -118.526643),
        "topRight" : CLLocationCoordinate2DMake(34.238316, -118.526002),
        "bottomRight" : CLLocationCoordinate2DMake(34.238108, -118.526003),
        "bottomLeft" : CLLocationCoordinate2DMake(34.238125, -118.526620)
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

    let NH : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.236737, -118.531904),
        "right" : CLLocationCoordinate2DMake(34.236871, -118.531557)
    ]
    
    let UN : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.239306, -118.531904),
        "right" : CLLocationCoordinate2DMake(34.239140, -118.531557)
    ]
    let EU : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.241102, -118.531904),
        "right" : CLLocationCoordinate2DMake(34.240957,  -118.531557)
    ]
    
    let JD : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.240992, -118.527476),
        "right" : CLLocationCoordinate2DMake(34.241102, -118.527265)
    ]
    let CS : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.239097, -118.527448),
        "right" : CLLocationCoordinate2DMake(34.239213, -118.527244)
    ]
    
    let VPAC : [String: CLLocationCoordinate2D] = [
        "left" : CLLocationCoordinate2DMake(34.236871, -118.527472),
        "right" : CLLocationCoordinate2DMake(34.236737, -118.527240)
    ]
    
    let redPath = [CLLocationCoordinate2DMake(34.236790, -118.531904),CLLocationCoordinate2DMake(34.239306, -118.531904),CLLocationCoordinate2DMake(34.241102, -118.531904),CLLocationCoordinate2DMake(34.241102, -118.527265),CLLocationCoordinate2DMake(34.239213, -118.527244),CLLocationCoordinate2DMake(34.236737, -118.527240),CLLocationCoordinate2DMake(34.236790, -118.531904)]
    
    let greenPath = [CLLocationCoordinate2DMake(34.236871, -118.531557),CLLocationCoordinate2DMake(34.239140, -118.531557),CLLocationCoordinate2DMake(34.240957,  -118.531557),CLLocationCoordinate2DMake(34.240992, -118.527476),CLLocationCoordinate2DMake(34.239097, -118.527448),CLLocationCoordinate2DMake(34.236871, -118.527472),CLLocationCoordinate2DMake(34.236871, -118.531557)]
    
    let B2 = CLLocationCoordinate2DMake(34.236969, -118.533812)
    let B4 = CLLocationCoordinate2DMake(34.239235, -118.533810)
    let B5 = CLLocationCoordinate2DMake(34.241989, -118.533583)
    let E6 = CLLocationCoordinate2DMake(34.242751, -118.529231)
    let F5 = CLLocationCoordinate2DMake(34.242736, -118.524686)
    let G3 = CLLocationCoordinate2DMake(34.238994, -118.525280)
    
    
    init() {
        clockwise["NH"] = NH["left"]
        clockwise["UN"] = UN["left"]
        clockwise["EU"] = EU["left"]
        clockwise["JD"] = JD["right"]
        clockwise["CS"] = CS["right"]
        clockwise["VPAC"] = VPAC["right"]
        
        counterClockwise["NH"] = NH["right"]
        counterClockwise["UN"] = UN["right"]
        counterClockwise["EU"] = EU["right"]
        counterClockwise["JD"] = JD["left"]
        counterClockwise["CS"] = CS["left"]
        counterClockwise["VPAC"] = VPAC["left"]
    }

    
}
