//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeViewModel: ObservableObject {
    
    //Card 1's stuff
    @Published var bestScore:                    Int?
    @Published var lastAvg:                      Double?
    //Card(s) (2...4)'s stuff
    @Published var avgTimeScoreInMS:             Double?
    @Published var numOfTries:                   Int = 0
    @Published var maxNumOfTries:                Int = 5
    //Card 4's stuff
    @Published var currentReactionTimeScoreInMS: Int = 0
    
    var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var isTimerOn: Bool = false
    
    @Published var currentScreenState: Int = 1
    
    func changeState(to x: Int) {
        if x >= 1 && x <= 5 {
            currentScreenState = x
        }
    }
    
    //MARK: - Intents
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
            //TODO: Finish this
        }
        print(numOfTries)
    }

    func isTooSoon() -> Bool {
        return false
    }
    func startTimer() {
        isTimerOn.toggle()
    }
}
