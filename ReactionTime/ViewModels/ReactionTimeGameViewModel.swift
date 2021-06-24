//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeGameViewModel: ObservableObject {
    
    
    var bgColor: (ScreenState) -> Color = { x in
        let rTGV = ReactionTimeGameView()
        switch x {
        case .START, .TOO_SOON, .TOO_LATE, .SCORE:
            return rTGV.blueColor
        case .WAIT:
            return rTGV.redColor
        case .TAP:
            return rTGV.greenColor
        }
    }
    
	//MARK: - Access to model
	@Published var m = ReactionTimeGameModel.init(maxNumOfTries: 3)
	
    //MARK: - Intents
    /// The logic behind when the user taps the main screen. This will take the user through all the states of the
    /// game.
	func tapScreen() {
        print("scores: \(m.scores)")
        print("best score rn: \(m.getTheBestScore())")
        print("bestScore: : \(m.getBestScore())")
		switch m.getCurrentScreenState() {
		
		case .START:
            m.setScreenState(.WAIT)
            m.setBestScore(0)
			randomCountDown()
			
		case .WAIT:
            //when you click too soon:
            m.setScreenState(.TOO_SOON)
            //startTimer() is called after x seconds and will go to .TAP automatically
		
        case .TOO_SOON:
            m.setScreenState(.WAIT)
    
		case .TAP:
			stopTimer() //when we CLICK, it stops
			m.incrementNumOfTries()
            m.scores.append(m.getCRTSInMS())
			m.updateAvg()
            m.setScreenState(.SCORE)
            
        case .TOO_LATE:
            m.setScreenState(.WAIT)
			
		case .SCORE:
            m.resetCurrentReactionTimeScoreInMS()
			if m.getNumOfTries() >= m.getMaxNumOfTries() {
                m.updateBestScore()
                m.updateLastAvg()
                m.setLastAvg(m.getAvgTimeScoreInMS())
                resetGame()
			}
			else {
                m.setScreenState(.WAIT)
				randomCountDown()
			}
		}
	}
    
    func resetGame() {
        m.setScreenState(.START)
        m.setNumOfTries(0)
        m.setAvgTimeScoreInMS(0)
        m.scores = []
    }
    
    /// Stops the timer
	func stopTimer() {
        m.isTimerOn.toggle()
		m.timer.invalidate()
	}
    
    /// Will increment the currentReactionTimeScoreInMS every millisecond until 20,000ms, then it will stop the timer
	func startTimer() {
		m.timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [self]_ in
			m.incrementTime()
            if m.getCRTSInMS() > 13000 {
                stopTimer()
                m.resetCurrentReactionTimeScoreInMS()
                m.setScreenState(.TOO_LATE)
                return
            }
		}
	}
	
	/// This function will automatically switch to the next screen
	/// and start the timer after a random amount of seconds have passed
	func randomCountDown() {
		let s = Int.random(in: 3...7)
		DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(s)) { [self] in
			if m.getCurrentScreenState() == .WAIT {
				startTimer()
                m.setScreenState(.TAP)
			}
		}
	}
    
    /// The logic behind what the titleText displays for each state
    /// - Parameters:
    ///   - x: The current screen state
    ///   - s: The time score in MS
    /// - Returns: The string for the titleText
    func determineTitleTextFromScreenState(screenstate: ScreenState, timescore s: Int) -> String {
        switch screenstate {
        case .START: return "Tap to Start!"
        case .WAIT: return "Wait for Green..."
        case .TOO_SOON: return "Too soon :("
        case .TOO_LATE: return "Too late :("
        case .TAP: return "Tap!"
        case .SCORE: return String(s) + "ms"
        }
    }
    
}


