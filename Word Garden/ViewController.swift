//
//  ViewController.swift
//  Word Garden
//
//  Created by Carter Borchetta on 9/15/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In viewDidLoad, is guessedLetterField the first responder?", guessedLetterField.isFirstResponder)
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder() // Dismisses keyboard from text field which is first responder at the time
        guessedLetterField.text = ""
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        // This type of action is triggered at any key press in the text field
        // This is the second IBAction associated with the text field
        print("Hey! the guessedLetterFieldChanged!!!")
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        // Primary action triggered is the done key being pressed on keyboard
        print("In doneKeyPressed, is guessedLetterField the first responder before update?", guessedLetterField.resignFirstResponder())
        updateUIAfterGuess()
        print("In doneKeyPressed, is guessedLetterField the first responder after update?", guessedLetterField.resignFirstResponder())
    }

    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        print("In guessLetterButtonPressed, is guessedLetterField the first responder before update?", guessedLetterField.resignFirstResponder())
        updateUIAfterGuess()
        print("In guessLetterButtonPressed, is guessedLetterField the first responder after update?", guessedLetterField.resignFirstResponder())

    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }

}

// 3.2 Notes
// First responder is the field or area that has first prtioty in collecting key presses or gestures
// Resigning first responder from a fiedl will dismiss the keyboard
// Add the done event from the keyboard done key from an IBAction from the text field
// Editing change IBAction responds to any keypress
// - The action is triggered at every key press
