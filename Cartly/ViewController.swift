//
//  ViewController.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 10/11/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    
    let locations = ["Jacaranda Hall", "Oviat Library", "Manzanita Hall", "Book Store", "Parking B5", "Parking B3"]
    
    var fromLocation : String!
    var toLocation : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromPicker.dataSource = self
        toPicker.dataSource = self
        fromPicker.delegate = self
        toPicker.delegate = self
    }
    
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
