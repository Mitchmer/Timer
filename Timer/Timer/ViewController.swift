//
//  ViewController.swift
//  Timer
//
//  Created by Mitch Merrell on 8/6/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: Properties
    
    var napTimer = NapTimer()
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        napTimer.startTimer(120)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: Custom Methods
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
