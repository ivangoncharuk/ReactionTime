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
    
    var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var isTimerOn: Bool = false
    
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
            currentScreenState = 2
        case 2:
            currentScreenState = 4
        case 3:
            currentScreenState = 2
        case 4:
            currentScreenState = 5
        case 5:
            currentScreenState = 1
        default:
            currentScreenState = 1
        }
    }
    func tappedTheScreenCopy() {
        switch currentScreenState {
        case 1:
            currentScreenState = 2
        case 2:
            currentScreenState = 3
        case 3:
            currentScreenState = 4
        case 4:
            currentScreenState = 5
        case 5:
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

    func startTimer() {
        isTimerOn.toggle()
    }
}
