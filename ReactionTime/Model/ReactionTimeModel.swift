//
//  ReactionTimeModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/15/21.
//

import SwiftUI

struct ReactionTimeModel {

    var bestScore:                    Int?
    var lastAvg:                      Int?
    var avgTimeScoreInMS:             Int?
    var currentScreenState:           Int
    var numOfTries:                   Int
    var maxNumOfTries:                Int
    var currentReactionTimeScoreInMS: Int
    var isTimerOn:                    Bool
    var timer:                        Timer
    
    init() {
        bestScore = nil
        lastAvg = nil
        avgTimeScoreInMS = nil
        currentScreenState = 1
        numOfTries = 0
        maxNumOfTries = 5
        currentReactionTimeScoreInMS = 0
        isTimerOn = false
        timer = Timer()
    }
    
    /**
         Handles the logic for when the user taps on the screen. There are 5 total screens, each with an int value arbitrarly assigned to it.
         1. Tap to Start!
         1. Wait for Green...
         1. Too Soon!
         1. Tap!
         1. results
     */

    
    mutating func incrementNumOfTries() {
        numOfTries += 1
        print("Number of tries: \(numOfTries)")
    }
    
    mutating func incrementTime() {
        currentReactionTimeScoreInMS += 1
    }

}
