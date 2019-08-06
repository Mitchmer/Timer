//
//  NapTimer.swift
//  Timer
//
//  Created by Mitch Merrell on 8/6/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

protocol NapTimerDelegate: class {
    
    func timerSecondTicked()
    func timerStopped()
    func timerCompleted()
}

class NapTimer {
    
    // MARK: Properties
    
    weak var delegate: NapTimerDelegate?
    private var timer: Timer?
    var timeLeft: TimeInterval?
    var isOn: Bool {
        // if no time left, return false, else return true
        return timeLeft == nil ? false : true
    }
    
    // MARK: Public Methods
    
    func startTimer(_ time: TimeInterval) {
        if isOn {
            print("Timer is already running")
        } else {
            self.timeLeft = time
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    func stopTimer() {
        timeLeft = nil
        // stops everything Timer is doing
        timer?.invalidate()
        print("Stopped timer!")
        // let the view controller know
        delegate?.timerStopped()
    }
    
    func timeLeftAsString() -> String {
        let timeRemaining = Int(timeLeft ?? 0)
        
        // tpta; to,e remaining (in seconds) divided by 60 to make minutes
        let minutesRemaining = timeRemaining / 60
        
        // subtract minutes * 60 from the total time remaining
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        // %02d allows the timer to show 2 digits, i.e. 10 : 01
        return String(format: "%02d : %02d", arguments: [minutesRemaining, secondsRemaining])
    }
    
    // MARK: Private Methods
    
    private func secondTicked() {
        guard let timeLeft = timeLeft else { return }
        
        if timeLeft > 0 {
            // lower time by one second
            
            self.timeLeft = timeLeft - 1
            print(self.timeLeftAsString())
            delegate?.timerSecondTicked()
            // let the view controller know
            
        } else {
            // timer complete
            
            stopTimer()
            delegate?.timerCompleted()
        }
    }
    
}
