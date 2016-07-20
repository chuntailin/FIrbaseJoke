//
//  Joke.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class Joke {

    private var _jokeRef: FIRDatabaseReference!
    
    private var _jokeKey: String!
    private var _jokeText: String!
    private var _jokeVotes: Int!
    private var _username: String!
    
    var jokeKey: String {
        return _jokeKey
    }
    
    var jokeText: String {
        return _jokeText
    }
    
    var jokeVotes: Int {
        return _jokeVotes
    }
    
    var username: String {
        return _username
    }
    
    init(key: String, dictionary: [String:AnyObject]) {
        self._jokeKey = key
        
        if let votes = dictionary["votes"] as? Int {
            self._jokeVotes = votes
        }

        if let joke = dictionary["jokeText"] as? String {
            self._jokeText = joke
        }
        
        if let user = dictionary["username"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
    
        self._jokeRef = DataService.dataService.JOKE_REF.child(self._jokeKey)
    }
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _jokeVotes = _jokeVotes + 1
        } else {
            _jokeVotes = _jokeVotes - 1
        }
        
        // Save the new vote total.
        
        _jokeRef.child("votes").setValue(_jokeVotes)
        
    }
}