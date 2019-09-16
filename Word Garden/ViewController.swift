//
//  ViewController.swift
//  Word Garden
//
//  Created by Carter Borchetta on 9/15/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Implicitly unwrapped optionals
    // Creating these containers without putting anything in them
    // Treat them like not optionlas becuase we know we're gonna have something there
    // Don't need to treat it like optional in rest of code
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        // Starts as an empty string with the text field also being an empty string sdo this call will just print the proper number of dashes
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder() // Dismisses keyboard from text field which is first responder at the time
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        // Can force unwrap text fields becuase when they are empty they contain ""
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord = revealedWord + " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        // Decrement the wrong guesses remaining and shows the next flower image with 1 less petal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        // Stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = " So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            // You've won the game so we have to end the game in this case as well
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            // Update our guess count label
            let guess = (guessCount == 1 ? "Guess" : "Guesses" )
            
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        // This type of action is triggered at any key press in the text field
        // This is the second IBAction associated with the text field
        if let letterGuessed = guessedLetterField.text?.last {
            // Attempt tp assign letterGuessed the last char of the text in the text field
            // Chaining nills
            // - the text field coud possibly return nil as could the result of.last
            // - thats why both of these things are optionals and why Xcode suggests a question mark after .text
            // - XCode will evaluate each thing that could be nil to see if it can make the assignment
            // Sees if .text is nill
            // - if it is it short circuits(moves to else)
            // - if not checks if .last is nil
            // - if it is it moves to else
            // - if not it makes the assignment
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        } else {
            // Will be getting nil if there is an empty string becuase "".last is nil
            guessLetterButton.isEnabled = false
            
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        // Primary action triggered is the done key being pressed on keyboard
        updateUIAfterGuess()
    }

    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        // Don't want to enable until we type something in
        
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        
        formatUserGuessLabel()
        // To mimic viewDidLoad Start
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }

}

// 3.4 Notes

// 3.3 Notes
// Implicitly unwrapped optionals
// We are defining something that we know has no value currently but that we are goubg to initialize later before we need it
// - Use ! so say lets just treat it not as optional becuase we know we'll fix it before we use it

// 3.2 Notes
// First responder is the field or area that has first prtioty in collecting key presses or gestures
// Resigning first responder from a fiedl will dismiss the keyboard
// Add the done event from the keyboard done key from an IBAction from the text field
// Editing change IBAction responds to any keypress
// - The action is triggered at every key press
