//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeGameViewModel: ObservableObject {
    func stopTimer() {
        model.isTimerOn.toggle()
        model.timer.invalidate()
    }
    
    func startTimer() {
        model.isTimerOn.toggle()
        model.timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [self]_ in
            model.incrementTime()
        }
    }

    func randomCountDown() {
        let s = Int.random(in: 3...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(s)) { [self] in
            if model.currentScreenState == .WAIT {
                startTimer()
                model.currentScreenState = .TAP
            }
        }
    }
    
    //MARK: - Access to model
    @Published var model = ReactionTimeGameModel.init()
    
    //MARK: - Intents
    func tapScreen() {
        switch model.currentScreenState {
        
            case .START:
                model.currentScreenState = .WAIT
                randomCountDown()
                
            case .WAIT:
                model.currentScreenState = .TOO_SOON
                //startTimer() is called after x seconds
                
            case .TOO_SOON:
                model.currentScreenState = .WAIT
                
            case .TAP:
                stopTimer() //when we CLICK, it stops
                model.incrementNumOfTries()
                model.currentScreenState = .SCORE
                print(model.currentReactionTimeScoreInMS)
                
            case .SCORE:
                model.resetTime()
                if model.numOfTries >= model.maxNumOfTries {
                    model.currentScreenState = .START
                    model.numOfTries = 0
                }
                else {
                    model.currentScreenState = .WAIT
                    randomCountDown()
                }
        }
    }
}
