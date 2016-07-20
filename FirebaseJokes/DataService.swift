//
//  DataService.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataService {
    static let dataService = DataService()
    
    private let _BASE_REF: FIRDatabaseReference
    private let _JOKE_REF: FIRDatabaseReference
    private let _USER_REF: FIRDatabaseReference
    
    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var JOKE_REF: FIRDatabaseReference {
        return _JOKE_REF
    }
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER: FIRDatabaseReference {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = _BASE_REF.child("users").child(userID)
        
        return currentUser
    }
    
    init() {
        self._BASE_REF = FIRDatabase.database().reference()
        self._USER_REF = _BASE_REF.child("users")
        self._JOKE_REF = _BASE_REF.child("jokes")
    }
    
    func createAccount(uid: String, user: [String:String]){
        USER_REF.child(uid).setValue(user)
    }
    
    func createJoke(joke: [String:AnyObject]){
        let newJokeNode = _JOKE_REF.childByAutoId()
        newJokeNode.setValue(joke)
    }
    
}