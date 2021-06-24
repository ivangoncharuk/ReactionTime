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
enum ScreenState {
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
	
	private var bestScore:                    Int
	private var lastAvg:                      Int?
	private var avgTimeScoreInMS:             Int
	private var numOfTries:                   Int
	private var maxNumOfTries:                Int
	private var currentReactionTimeScoreInMS: Int
	private var currentScreenState:           ScreenState
	
    var isTimerOn:                            Bool
    var timer:                                Timer
    var scores:                               [Int]

	
    init(maxNumOfTries maxNofTs: Int) {
		bestScore = 0
		lastAvg = nil
		avgTimeScoreInMS = 0
		numOfTries = 0
		maxNumOfTries = maxNofTs
		isTimerOn = false
		timer = Timer()
		currentReactionTimeScoreInMS = 0
		currentScreenState = .START
        scores = []
	}
    
    //MARK: - Getters and setters
    // setting && getting bestScore
    mutating func setBestScore(_ int: Int) {
        self.bestScore = int
    }
    func getBestScore() -> Int {
        return bestScore
    }
    // setting && getting lastAvg
    mutating func setLastAvg(_ lastAvg: Int) {
        self.lastAvg = lastAvg
    }
    func getLastAvg() -> Int? {
        return self.lastAvg
    }
    //setting && getting avgTimeScoreInMS
    mutating func setAvgTimeScoreInMS(_ x: Int) {
        self.avgTimeScoreInMS = x
    }
    func getAvgTimeScoreInMS() -> Int {
        return self.avgTimeScoreInMS
    }
    //setting && getting numOfTries
    mutating func setNumOfTries(_ x: Int) {
        self.numOfTries = x
    }
    func getNumOfTries() -> Int {
        return self.numOfTries
    }
    
    //setting && getting maxNumOfTries
    mutating func setMaxNumOfTries(_ x: Int) {
        self.maxNumOfTries = x
    }
    func getMaxNumOfTries() -> Int {
        return maxNumOfTries
    }
    
    //getting currentReactionTimeScoreInMS
    func getCRTSInMS() -> Int{
        return self.currentReactionTimeScoreInMS
    }
    
    //setting && getting setScreenState
    mutating func setScreenState(_ ss: ScreenState) {
        self.currentScreenState = ss
    }
    func getCurrentScreenState() -> ScreenState {
        return self.currentScreenState
    }
    
    
    /// Increments the numOfTries integer variable
	mutating func incrementNumOfTries() {
        self.numOfTries += 1
	}
    
    /// Increments the current time score by 1 every time its called.
	mutating func incrementTime() {
        self.currentReactionTimeScoreInMS += 1
	}
    
    /// Resets the current reaction time score.
	mutating func resetCurrentReactionTimeScoreInMS() {
        self.currentReactionTimeScoreInMS = 0
	}
    
    /// Updates the average time score for the current time trials.
	mutating func updateAvg() {
        var totalScore: Int = 0
        for i in self.scores {
            totalScore += i
        }
        self.avgTimeScoreInMS = totalScore/self.numOfTries
	}
    
    mutating func updateBestScore() {
        bestScore = getTheBestScore()
    }
    func getTheBestScore() -> Int {
        var a = 0
        if scores.count > 0 {
            for x in 0...scores.count - 1 {
                if scores[x] < a {
                    a = scores[x]
                }
            }
        }
        return a
    }
    
    mutating func updateLastAvg() {
        self.lastAvg = avgTimeScoreInMS        
    }
    
}
