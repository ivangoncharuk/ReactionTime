//
//  ReactionTimeModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/15/21.
//

import SwiftUI

/**
 All the current states of the game screen
 
 START           -->     "Start Screen"
 
 WAIT              -->     "Wait Screen"
 
 TOO_SOON  -->     "Too Soon! Screen"
 
 TAP                -->     "Tap! Screen"
 
 SCORE          -->     "Score Screen"
 */
enum ScreenStates {
	case START
	case WAIT
	case TOO_SOON
    case TOO_LATE
	case TAP
	case SCORE
	
	var description: String {
		switch self {
		case .START: return "Start Screen"
		case .WAIT: return "Wait Screen"
		case .TOO_SOON: return "Too Soon! Screen"
        case .TOO_LATE: return "Too Late! Screen"
		case .TAP: return "Tap! Screen"
		case .SCORE: return "Score Screen"

        }
	}
}

/// The model for the Reaction Time Game
struct ReactionTimeGameModel {
	
	var bestScore:                    Int?
	var lastAvg:                      Int?
	var avgTimeScoreInMS:             Int
	var numOfTries:                   Int
	var maxNumOfTries:                Int
	var isTimerOn:                    Bool
	var timer:                        Timer
	var currentReactionTimeScoreInMS: Int
	var currentScreenState:           ScreenStates
    var scores:                       [Int]
	
	
	init() {
		bestScore = nil
		lastAvg = nil
		avgTimeScoreInMS = 0
		numOfTries = 0
		maxNumOfTries = 5
		isTimerOn = false
		timer = Timer()
		currentReactionTimeScoreInMS = 0
		currentScreenState = .START
        scores = []
	}
    
    
    /// Increments the numOfTries integer variable
	mutating func incrementNumOfTries() {
		numOfTries += 1
	}
    
    /// Increments the current time score by 1 every time its called.
	mutating func incrementTime() {
		currentReactionTimeScoreInMS += 1
	}
    
	mutating func resetCurrentReactionTimeScoreInMS() {
		currentReactionTimeScoreInMS = 0
	}
	
	mutating func updateAvg() {
        scores.append(currentReactionTimeScoreInMS)
        var totalScore: Int = 0
        for i in scores {
            totalScore += i
        }
        avgTimeScoreInMS = totalScore/scores.count
	}
}
