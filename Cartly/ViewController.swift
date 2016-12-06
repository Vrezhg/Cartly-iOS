//
//  ViewController.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 10/11/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var driverSwitch: UISwitch!
    
    //Could maybe even Narrow down locations by (buildings), (parking lots), (sports), (food)
    //Could also have someone type and the list of locations matches keyword to narrow down locations as they type
    let locations = ["Art and Design Center", "Arbor Court", "Athletics Office Building", "Bayramian Hall", "Brown Center", "Central Plant", "Chaparral Hall", "Chicano House", "Childrens Center", "Citrus Hall", "Cypress Hall", "Donald Bianchi Planetarium", "Duck Pond", "Education", "Eucalyptus Hall", "Extended University Commons", "Greenhouse", "Grand Salon(USU)", "Jacaranda Hall", "Jeanne Chisholm Hall", "Jerome Richfield Hall", "Johnson Auditorium", "Juniper Hall", "KCSN", "Klotz Student Health Center", "Laurel Hall", "Live Oak Hall", "Magnolia Hall", "Manzanita Hall", "Matador Bookstore", "Matador Hall", "Monterey Hall", "National Center On Deafness", "Nautilus Center/Fitness Center", "Nordhoff Hall", "Noski Auditorium", "Orange Grove", "Orange Grove Bistro", "Oviatt Library", "Physical Plant Management", "Police Services", "Pride Center", "Sagebrush Hall", "Santa Susana Hall", "Satellite Student Union (SSU)", "Student Recreation Center","Redwood Hall/Matadome", "Student Recreation Center Field", "Sequoia Hall", "Sierra Center", "Sierra Hall", "SRC", "Tseng College", "University Hall", "University Student Union(USU)", "Valley Performing Arts Center (VPAC)","B1 Parking Lot", "B2 Parking Lot", "B3 Parking Lot", "B3 Parking Structure", "B4 Parking Lot", "B5 Parking Lot", "B5 Parking Structure", "D6 Parking Lot", "E6 Parking Lot", "F5 Parking Lot", "F7 Parking Lot", "F8 Parking Lot", "F9 Parking Lot", "F10 Parking Lot", "G1 Parking Lot", "G3 Parking Lot", "G3 Parking Structure", "G4 Parking Lot", "G7 Parking Lot", "Baseball Field", "Golf", "North Field", "Tennis Courts", "Matador Track Stadium", "Sand Volleyball", "Soccer Field", "Soccer Practice Field", "Softball Field"]
    
    var fromLocation = ""
    var toLocation = ""
//    var locationCoordinates = PickupLocations().locations
    
    var currentUser: FIRUser?

    override func viewDidLoad() {

        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        super.viewDidLoad()
        fromPicker.dataSource = self
        toPicker.dataSource = self
        fromPicker.delegate = self
        toPicker.delegate = self
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "csunBackground.jpg")!)
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                self.currentUser = user
            } else {
                // No user is signed in.
                self.currentUser = nil
            }
        }
    }
    @IBAction func driverSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            if let user = currentUser {
                // check if this user is also a driver
                let databaseReference = FIRDatabase.database().reference()
                databaseReference.child("Users").child(user.uid).child("isDriver").observeSingleEvent(of: .value, with: { (snapshot) in
                    if let value = snapshot.value as? String {
                        if value == "true" {
                            // returned true
                            // add to online drivers, send to map, update location periodically
                            // let rider track location
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "sendDriverToMap", sender: nil)
                            }
                        } else {
                            let alert = self.basicDestructiveAlert(title: "Error", message: "You're not signed up as a driver.", style: .alert)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    } else {
                        print("error fetching user driver id")
                    }
                }) 
            } else {
                // turn off switch and ask them to log in
                driverSwitch.setOn(false, animated: true)
                performSegue(withIdentifier: "gotoLogin", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDriverToMap" {
            let mapController = segue.destination as? MapViewController
            mapController?.driverMode = true
        }
    }

    @IBAction func selectOnMapPressed(_ sender: UIButton) {
        if currentUser == nil{
            performSegue(withIdentifier: "gotoLogin", sender: nil)
        } else {
            performSegue(withIdentifier: "gotoMap", sender: nil)
        }
    }
    @IBAction func requestPressed(_ sender: UIButton) {
        if currentUser == nil{
            performSegue(withIdentifier: "gotoLogin", sender: nil)
        } else {
            //make request with selected locations
    
        }
    }
    
    // NAVIGATION 
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "makeRequest" {
//            let mapViewController = segue.destination as? MapViewController
//            mapViewController?.start
//            mapViewController?.end
//        }
//    }

    // MARK - From and To Picker
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            fromLocation = locations[row]
        } else {
            toLocation = locations[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView.tag == 0 {
            return NSAttributedString(string: locations[row], attributes: [NSForegroundColorAttributeName:UIColor.black])
        } else {
            return NSAttributedString(string: locations[row], attributes: [NSForegroundColorAttributeName:UIColor.black])
            
        }
    }

}
