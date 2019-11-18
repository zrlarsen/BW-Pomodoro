//
//  Pomodoro.swift
//  buildweek
//
//  Created by Zack Larsen on 11/18/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import Foundation

protocol PomodoroDelegate: class {
    func countdownDidUpdate(timeRemaining: TimeInterval)
    func countdownDidFinish()
    
}

enum TimerState {
    case started
    case finished
    case reset
}

class Countdown {
    
    weak var delegate: PomodoroDelegate?
    var duration: TimeInterval
    var timer: Timer?
    var stopDate: Date?
    var state: TimerState
    
    
    var timeRemaining: TimeInterval {
        if let stopDate = stopDate {
            let timeRemaing = stopDate.timeIntervalSinceNow
            return timeRemaing
            } else {
            return 0
        }
    }
    init() {
        timer = nil
        stopDate = nil
        duration = 0
        state = .finished
    }
    
    func start() {
        cancelTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: false, block: updateTimer(timer:))
        stopDate = Date().addingTimeInterval(duration)
        state = .started
    }
    
    func updateTimer(timer: Timer) {
        if let stopDate = stopDate {
            let currentTime = Date()
            
            if currentTime <= stopDate {
                
                delegate?.countdownDidUpdate(timeRemaining: timeRemaining)
            } else {
                state = .finished
                cancelTimer()
                self.stopDate = nil
                delegate?.countdownDidFinish()
                
            }
        }
    }
    func reset() {
        stopDate = nil
        cancelTimer()
        state = .reset
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
}


