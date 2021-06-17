//
//  ContentView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI


struct ReactionTimeGameView: View {
    
    //MARK: - Access to the view model
    @ObservedObject var vM = ReactionTimeGameViewModel.init()
    
    let descriptionText: String = "When the red box turns green, tap as quickly as you can."
    let greenColor: Color       = Color(#colorLiteral(red: 0.29623577, green: 0.8585592508, blue: 0.4167816639, alpha: 1))
    let blueColor: Color        = Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1))
    let textPrimaryColor: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let redColor: Color         = Color(#colorLiteral(red: 0.806209743, green: 0.1509520113, blue: 0.2106329799, alpha: 1))
    
    var body: some View {
        
        //MARK: - renaming these so my params arent super long :)
        let curScreenSt = vM.model.currentScreenState
        let bestScore = vM.model.bestScore
        let numOfTries = vM.model.numOfTries
        let maxNumOfTries = vM.model.maxNumOfTries
        let lastAvg = vM.model.lastAvg
        let titleText: String = vM.determineTitleTextFromScreenState(
            screenstate: curScreenSt,
            timescore: vM.model.currentReactionTimeScoreInMS
        )

        ZStack {
            TemplateScreenView(backGroundColor: vM.bgColor(curScreenSt),
                               titleText: titleText,
                               subTitleText1:  (curScreenSt == .START) ? "Best Score" : "Average",
                               subTitleValue1: (curScreenSt == .START) ? "\(bestScore ?? 0)ms" : "\(vM.model.avgTimeScoreInMS)ms",
                               subTitleText2:  (curScreenSt == .START) ? "Last Average" : "Tries",
                               subTitleValue2: (curScreenSt == .START) ? "\(lastAvg ?? 0)ms" : "\(numOfTries) of \(maxNumOfTries)",
                               textColor: textPrimaryColor,
                               middleText: (curScreenSt == .START) ? descriptionText :
                                           (curScreenSt == .TOO_SOON) ? "Tap to try again" :
                                           (curScreenSt == .TOO_LATE) ?  "You took too long" : "")
                .onTapGesture {
                    vM.tapScreen()
                }

            TestingView(score: vM.model.currentReactionTimeScoreInMS,
                        css: curScreenSt.description)
            
            IconView(curScreenSt: vM.model.currentScreenState)
            
        }
    }
}

/// This is for the content preview screen
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionTimeGameView()
    }
}
 
