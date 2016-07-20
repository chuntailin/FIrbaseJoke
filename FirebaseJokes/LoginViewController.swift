//
//  LoginViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func tryLogin(sender: AnyObject) {
        
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            FIRAuth.auth()?.signInWithEmail(email!, password: password!, completion: { (user, error) in
                if error == nil {
                    NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey: "uid")
                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                } else {
                    self.signInErrorAlert("Oops!", message: "Having some trouble to sign in")
                }
            })
        } else {
            self.signInErrorAlert("Error", message: "Enter the email and password")
        }
    }
    
    func signInErrorAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
