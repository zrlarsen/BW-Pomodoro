//
//  PomodoroViewController.swift
//  buildweek
//
//  Created by Zack Larsen on 11/18/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PomodoroViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var breakButton: UIButton!
    
    let countdown = Countdown()
   
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private var countdownLabel: [[String]] = {
        
        let minutes: [String] = Array(0...25).map({ String($0) })
        let seconds: [String] = Array(0...59).map({ String($0) })
        
        return [minutes, ["min"], seconds, ["sec"]]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 countdown.delegate = self
        
    }
    
    func updateViews() {
        switch countdown.state {
        case .started:
            timerLabel.adjustsFontSizeToFitWidth = true
            timerLabel.text = string(from:countdown.timeRemaining)
        case.finished:
            timerLabel.text = string(from: 0)
            startButton.isEnabled = true
        case .reset:
            timerLabel.text = string(from: countdown.duration); startButton.isEnabled = false
        }
    }
    func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Pomodoro Finished!", message: "Start your break now.", preferredStyle: .alert)
        
        let breakAction = UIAlertAction(title: "Take a Break", style: .default, handler: nil)
        
        alert.addAction(breakAction)
        
        
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        countdown.start()
        updateViews()
    }
    
    @IBAction func breakButton(_ sender: Any) {
        countdown.start()
        updateViews()
    }
    
}
  
extension PomodoroViewController: PomodoroDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
        
    }
    func countdownDidFinish() {
        showAlert()
        updateViews()
    }
}

