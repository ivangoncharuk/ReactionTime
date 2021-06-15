//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeViewModel: ObservableObject {
    
    func tappedTheScreen() {
        //after i tap on the screen when I'm on the...
        switch model.currentScreenState {
        //tap to start! page
        case 1:
            model.currentScreenState = 2
            print("\(model.currentScreenState)")
            randomCountDown()
        //the wait page
        case 2:
            model.currentScreenState = 3
        //the too soon! page
        case 3:
            model.currentScreenState = 2
        //tap! page
        case 4:
            stopTimer()
            model.incrementNumOfTries()
            model.currentScreenState = 5
        //score page
        case 5:
            model.currentReactionTimeScoreInMS = 0
            if model.numOfTries >= model.maxNumOfTries {
                model.currentScreenState = 1
                model.numOfTries = 0
            }
            else {
                model.currentScreenState = 2
                randomCountDown()
            }
        default:
            model.currentScreenState = 1
        }
    }
    
    func randomCountDown() {
        let s = Int.random(in: 3...7)
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(s)) {
            if self.model.currentScreenState == 2 {
                print("inside the if statement")
                self.model.currentScreenState = 4
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
    @Published var model = ReactionTimeModel()
    
    //MARK: - Intents
    
}
