//
//  CreateAccountViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" {
            //創建使用者
            FIRAuth.auth()?.createUserWithEmail(email!, password: password!, completion: { (user, error) in
                if error == nil {
                    FIREmailPasswordAuthProvider.credentialWithEmail(email!, password: password!)
                    
                    let userInfo = ["provider":user!.providerID, "email":email!, "username":username!]
                    //將使用者的資訊加進Database的node中
                    DataService.dataService.createAccount((user?.uid)!, user: userInfo)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.signUpErrorAlert("Oops!", message: "Having some trouble to create your account")
                }
            })
        } else {
           signUpErrorAlert("Error", message: "Don't forget to enter email and password!")
        }
    }
    
    func signUpErrorAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}
