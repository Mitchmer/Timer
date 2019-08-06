//
//  ViewController.swift
//  Timer
//
//  Created by Mitch Merrell on 8/6/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: Properties
    
    var napTimer = NapTimer()
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        napTimer.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        
        if napTimer.isOn {
            napTimer.stopTimer()
        } else {
            napTimer.startTimer(8)
        }
    }
    
    // MARK: Custom Methods

    func updateLabelAndButton() {
        timerLabel.text = napTimer.timeLeftAsString()
        
        var buttonTitle = ""
        var buttonColor: UIColor = .white
        
        if napTimer.isOn {
            buttonTitle = "STOP"
            buttonColor = .red
        } else {
            buttonTitle = "START"
            buttonColor = .green
        }
        
        timerButton.setTitle(buttonTitle, for: .normal)
        timerButton.setTitleColor(buttonColor, for: .normal)
    }
    
    func scheduleLocalAlert(in timeInterval: TimeInterval) {
        
        //content of our notification (what it looks like)
        let content = UNMutableNotificationContent()
        content.title = "Time's up"
        content.body = "All your time ran out!"
        content.sound = UNNotificationSound.default
        
        //how long into the future it will be scheduled
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // the completed request (content + trigger)
        let request = UNNotificationRequest(identifier: "napTimer", content: content, trigger: trigger)
        
        // schedule the request
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                
                print("NOTIFICATION FAILED")
                print(error.localizedDescription)
                print(error)
            }
        }
    }
}


// MARK: NapTimer delegate

extension ViewController: NapTimerDelegate {
    
    func timerSecondTicked() {
        updateLabelAndButton()
    }
    
    func timerStopped() {
        updateLabelAndButton()
    }
    
    func timerCompleted() {
        presentAlert()

    }
    
    func presentAlert() {
        // create alert controller
        
        let alertController = UIAlertController(title: "TIME'S UP", message: "Do you want to keep sleeping?", preferredStyle: .alert)
        
        // add textdield and actions
        
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "How many more seconds of sleep?"
        }
        
        let dismissAction = UIAlertAction(title: "I'm awake", style: .cancel, handler: nil)
        let snoozeAction = UIAlertAction(title: "Snooze", style: .default) { (_) in
            // IF there's a textfield
            if let textField = alertController.textFields?.first,
                
                // and IF there's text in it
                let inputText = textField.text,
                
                // and IF that text is convertable to a double
                let textAsDouble = Double(inputText) {
                
                // THEN start the timer over
                self.napTimer.startTimer(textAsDouble)
                self.scheduleLocalAlert(in: textAsDouble)
            }
        }
        
        // assigns alerts to the alert controller we made
        alertController.addAction(dismissAction)
        alertController.addAction(snoozeAction)
        
        // present alert controller
        
        present(alertController, animated: true)
    }
}

