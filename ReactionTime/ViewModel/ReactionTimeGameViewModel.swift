//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeGameViewModel: ObservableObject {
    
    
    /// This function handles how the program reacts to when they tap the whole
    /// screen depending on which the currentScreenState is
    func tappedTheScreen() {
        
        switch model.currentScreenState {
        
            case .START:
                model.currentScreenState = .WAIT
                randomCountDown()
                
            case .WAIT:
                model.currentScreenState = .TOO_SOON
                
            case .TOO_SOON:
                model.currentScreenState = .WAIT
                
            case .TAP:
                stopTimer()
                model.incrementNumOfTries()
                model.currentScreenState = .SCORE
                
            case .SCORE:
                model.currentReactionTimeScoreInMS = 0
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
    
    func randomCountDown() {
        let s = Int.random(in: 3...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(s)) {
            if self.model.currentScreenState == .WAIT {
                print("inside the if statement")
                self.model.currentScreenState = .TAP
                self.startTimer()
            }
        }
    }
    
    func startTimer() {
        model.isTimerOn.toggle()
        model.timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) {_ in
            self.model.currentReactionTimeScoreInMS += 1
        }
    }
    
    func stopTimer() {
        model.isTimerOn.toggle()
        model.timer.invalidate()
    }
    
    //MARK: - Access to model
    @Published var model = ReactionTimeGameModel()
    
    //MARK: - Intents
    
}
