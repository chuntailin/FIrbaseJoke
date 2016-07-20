//
//  AddJokeViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddJokeViewController: UIViewController {
    
    @IBOutlet weak var jokeField: UITextField!
    var currentUsername: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUsername()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getCurrentUsername(){
        DataService.dataService.CURRENT_USER.observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
            let currentUser = snapshot.value?.objectForKey("username") as! String
            self.currentUsername = currentUser
        }
    }
    
    @IBAction func saveJoke(sender: AnyObject) {
        let jokeText = jokeField.text!
        let newJoke: [String:AnyObject] = ["jokeText":jokeText, "votes":0, "author":currentUsername]
        
        DataService.dataService.createJoke(newJoke)
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        do {
            try FIRAuth.auth()?.signOut()
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
            
            print(NSUserDefaults.standardUserDefaults().valueForKey("uid"))
            
            let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
            UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
        } catch let signOutError as NSError{
            print(signOutError)
        }
    }
}
