//
//  JokeCellTableViewCell.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class JokeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jokeText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalVotesLabel: UILabel!
    @IBOutlet weak var thumbVoteImage: UIImageView!
    
    var joke: Joke!
    var voteRef: FIRDatabaseReference!
    
    func configureCell(joke: Joke) {
        self.joke = joke
        
        self.jokeText.text = joke.jokeText
        self.totalVotesLabel.text = "Total Votes: \(joke.jokeVotes)"
        self.usernameLabel.text = joke.username
        
        voteRef = DataService.dataService.CURRENT_USER.child("votes").child(joke.jokeKey)
        
        voteRef.observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
            } else {
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
            }
        }
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                
                self.joke.addSubtractVote(true)
                self.voteRef.setValue(true)
            } else {
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                self.joke.addSubtractVote(false)
                self.voteRef.removeValue()
            }
            
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        let tap = UITapGestureRecognizer(target: self, action: "voteTapped:")
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }


}
