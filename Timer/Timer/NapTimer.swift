//
//  NapTimer.swift
//  Timer
//
//  Created by Mitch Merrell on 8/6/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

class NapTimer {
    
    // MARK: Properties
    
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
            self.timer = Timer(timeInterval: 1, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    func stopTimer() {
        timeLeft = nil
        timer?.invalidate()
        print("Stopped timer!")
        // let the view controller know
        
    }
    
    // MARK: Private Methods
    
    private func secondTicked() {
        guard let timeLeft = timeLeft else { return }
        
        if timeLeft > 0 {
            // lower time by one second
            
            self.timeLeft = timeLeft - 1
            print(self.timeLeft as Any)
            
            // let the view controller know
            
        } else {
            // timer complete
            
            stopTimer()
        }
    }
    
}
