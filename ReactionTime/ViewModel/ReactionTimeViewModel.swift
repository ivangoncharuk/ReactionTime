//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeViewModel: ObservableObject {
    
    //Card 1's stuff
    @Published var bestScore:               Int?
    @Published var lastAvg:                 Double?
    //Card(s) (2...4)'s stuff
    @Published var avgTimeScoreInMS:        Double?
    @Published var numOfTries:              Int = 0
    @Published var maxNumOfTries:           Int = 5
    //Card 4's stuff
    @Published var reactionTimeScoreInMS:   Double?
    
    @Published var currentScreenState: ScreenState = ScreenState.startScreen
    
    enum ScreenState {
        case startScreen, waitForGreenScreen, tooSoonScreen, tapScreen, resultScreen
    }
    func timer() {
    }
    
    //MARK: - Intents
    func resetGame() {
        currentScreenState = ScreenState.startScreen
        bestScore = nil
        lastAvg = nil
        avgTimeScoreInMS = nil
        numOfTries = 0
        maxNumOfTries = 5
    }
    func incrementNumOfTries() {
        numOfTries += 1
    }
    func changeScreen(to screen: ScreenState) {
        currentScreenState = screen
    }
    func isTooSoon() -> Bool {
        return false
    }
}
