//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeViewModel: ObservableObject {

    @Published var bestScore:                    Int?
    @Published var lastAvg:                      Double?
    @Published var avgTimeScoreInMS:             Double?
    @Published var numOfTries:                   Int = 0
    @Published var maxNumOfTries:                Int = 5
    @Published var currentReactionTimeScoreInMS: Int = 0
    
    @Published var timer = Timer()
    @Published var isTimerOn: Bool = false
    
    @Published var timer2 = Timer()
    @Published var isTimer2On: Bool = false
    @Published var timePassed: Int = 0
    
    @Published var currentScreenState: Int = 1
    
    //MARK: - Intents
    /**
     Handles the logic for when the user taps on the screen. There are 5 total screens, each with an int value arbitrarly assigned to it.

      1. Tap to Start!
      1. Wait for Green...
      1. Too Soon!
      1. Tap!
      1. results
     */
    func tappedTheScreen() {
        switch currentScreenState {
        case 1:
            //just goes to wait screen
            currentScreenState = 2
            randomCountDown()
        case 2:
            currentScreenState = 3
        case 3:
            currentScreenState = 2
        case 4:
            stopTimer()
            currentScreenState = 5
        case 5:
            currentReactionTimeScoreInMS = 0
            currentScreenState = 1
        default:
            currentScreenState = 1
        }
    }
    
    func resetGame() {
        currentScreenState = 1
        bestScore = nil
        lastAvg = nil
        avgTimeScoreInMS = nil
        numOfTries = 0
        maxNumOfTries = 5
    }
    func incrementNumOfTries() {
        if numOfTries < maxNumOfTries{
            numOfTries += 1
        } else {
            numOfTries = 0
        }
        print(numOfTries)
    }
    func incrementTime() {
        currentReactionTimeScoreInMS += 1
    }

    func startTimer() {
        isTimerOn.toggle()
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) {timer in
            self.currentReactionTimeScoreInMS += 1
        }
    }
    func stopTimer() {
        isTimerOn.toggle()
        timer.invalidate()
    }
    func randomCountDown() {
        let s = Int.random(in: 3...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(s)) {
            if self.currentScreenState == 2 {
                self.currentScreenState = 4
                self.startTimer()
            }
        }
    }
}
