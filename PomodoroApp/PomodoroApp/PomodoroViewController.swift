//
//  PomodoroViewController.swift
//  PomodoroApp
//
//  Created by Zack Larsen on 11/21/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.

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
            breakButton.isEnabled = true
        case .reset:
            timerLabel.text = string(from: countdown.duration); startButton.isEnabled = false
                breakButton.isEnabled = false
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
        present(alert, animated: true)
    }
    
    func showBreakAlert() {
        let breakAlert = UIAlertController(title: "Break Finished!", message: "Back to work.", preferredStyle: .alert)
        
        let breakAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        breakAlert.addAction(breakAction)
        
        present(breakAlert, animated: true)
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        countdown.duration = 5
        countdown.reset()
        countdown.start()
        updateViews()
        startButton.isEnabled.toggle()
    }
    
    @IBAction func breakButton(_ sender: Any) {
        countdown.duration = 5
        countdown.reset()
        countdown.start()
        updateViews()
        breakButton.isEnabled.toggle()
    }
    
}
  
extension PomodoroViewController: PomodoroDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
       updateViews()
    }
    func countdownDidFinish() {
        if startButton.isEnabled == false {
            showAlert()
            updateViews()
        } else {
            showBreakAlert()
        }
        updateViews()
    }
}


