//
//  LoginViewController.swift
//  Cartly
//
//  Created by Vrezh Gulyan on 12/3/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func basicDestructiveAlert(title : String, message : String, style : UIAlertControllerStyle) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        return alert
    }
}


class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var databaseRef = FIRDatabase.database().reference()
    var currentUser : FIRUser?
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
        
    }
    @IBAction func signupPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if (email == "" || password == ""){
                let alert = self.basicDestructiveAlert(title: "Error", message: "All fields must be filled in.", style: .alert)
                present(alert, animated: true, completion: nil)
            } else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
                    (user, error) in
                    //self.progressView.removeFromSuperview()
                    if error != nil {
                        let alert = self.basicDestructiveAlert(title: "Error signing up", message: (error?.localizedDescription)!, style: .alert)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.currentUser = user
                        let userInfo : [AnyHashable : Any] = [AnyHashable("email") : email, AnyHashable("isDriver") : "false"]
                        
                        self.databaseRef.child("Users").child((user?.uid)!).updateChildValues(userInfo
                            , withCompletionBlock: { (error, reference) in
                                if (error == nil) {
                                    print("Signed Up")
                                    let _ = self.navigationController?.popViewController(animated: true)
                                } else {
                                    if let errorDescription = error?.localizedDescription{
                                        print(errorDescription)
                                    }
                                }
                        })
                    }
                })
            }
        }

    }
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if (email == "" ||  password == "") {
                let alert = self.basicDestructiveAlert(title: "Error", message: "Both username and password must be filled in.", style: .alert)
                present(alert, animated: true, completion: nil)
            } else {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
                    (user, error) in
                    //self.progressView.removeFromSuperview()
                    if let currentUser = user {
                        self.currentUser = currentUser
                        let _ = self.navigationController?.popViewController(animated: true)
                    } else {
                        let alert = self.basicDestructiveAlert(title: "Error logging in.", message: (error?.localizedDescription)! , style: .alert)
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }

    }
    
}
