//
//  ReactionTimeModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/15/21.
//

import SwiftUI

enum ScreenStates {
    case START
    case WAIT
    case TOO_SOON
    case TAP
    case SCORE
    
    var description : String {
        switch self {
        case .START: return "Start Screen"
        case .WAIT: return "Wait Screen"
        case .TOO_SOON: return "Too Soon! Screen"
        case .TAP: return "Tap! Screen"
        case .SCORE: return "Score Screen"
        }
    }
}

struct ReactionTimeGameModel {

    var bestScore:                    Int?
    var lastAvg:                      Int?
    var avgTimeScoreInMS:             Int?
    var numOfTries:                   Int
    var maxNumOfTries:                Int
    var isTimerOn:                    Bool
    var timer:                        Timer
    var currentReactionTimeScoreInMS: Int
    var currentScreenState:           ScreenStates

    init() {
        bestScore = nil
        lastAvg = nil
        avgTimeScoreInMS = nil
        numOfTries = 0
        maxNumOfTries = 5
        isTimerOn = false
        timer = Timer()
        currentReactionTimeScoreInMS = 0
        currentScreenState = .START
    }
    
    mutating func incrementNumOfTries() {
        numOfTries += 1
        print("Number of tries: \(numOfTries)")
    }
    
    mutating func incrementTime() {
        currentReactionTimeScoreInMS += 1
    }
    
    mutating func resetTime() {
        currentReactionTimeScoreInMS = 0
    }
    
}
