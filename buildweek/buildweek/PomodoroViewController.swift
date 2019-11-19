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
    
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    
    let countdown = Countdown()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss."
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    func updateViews() {
        switch countdown.state {
        case .started:
            timerLabel.text = string(from:countdown.timeRemaining)
        case.finished:
            timerLabel.text = string(from: 0)
            workButton.isEnabled = true
        default:
            <#code#>
        }
    }
    func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
}
   

