//
//  ContentView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI


struct ReactionTimeView: View {
    @StateObject private var reactionTimeViewModel = ReactionTimeViewModel()
    
    let redColor: Color         = Color(#colorLiteral(red: 0.806209743, green: 0.1509520113, blue: 0.2106329799, alpha: 1))
    let greenColor: Color       = Color(#colorLiteral(red: 0.29623577, green: 0.8585592508, blue: 0.4167816639, alpha: 1))
    let blueColor: Color        = Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1))
    let textPrimaryColor: Color = Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    
    var body: some View {
        //Screen 1 "Tap to start!"
        ScreenOne(bestScore: nil, bestLastAverageScore: nil)
            .onTapGesture {
                reactionTimeViewModel.incrementNumOfTries()
                print("\(reactionTimeViewModel.numOfTries)")
            }
        
        //Screen 2 "Wait for green"
        //ScreenTwo(averageScore: nil, numOfTries: nil, maxNumOfTries: 5)
        
        //Screen 3 "Tap"
        //ScreenThree(averageScore: nil, numOfTries: nil, maxNumOfTries: 5)
        
        //Screen 4 "Finished"
        //ScreenFour(score: nil, averageScore: nil, numOfTries: nil, maxNumOfTries: 5)
        //Screen 5 "Too soon!"
        //TODO: Make a "Too soon!" screen.
        //ScreenFour(score: 69, averageScore: nil, numOfTries: nil, maxNumOfTries: 40)
        
        
        
    }
}
/**
 var backGroundColor: Color = Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1))
 var titleText: String = "Tap to Start!"
 var subTitleText1: String = "Best"
 var subTitleValue1: String = "0ms"
 var subTitleText2: String = "Last"
 var subTitleValue2: String = "0ms"
 */


/// This view is for the template for each screen.
struct Template: View {
    var backGroundColor: Color
    var titleText: String
    var subTitleText1: String
    var subTitleValue1: String
    var subTitleText2: String
    var subTitleValue2: String
    var textColor: Color
    
    var middleText: String?
    var body: some View {
        
        ZStack {
            let smallTextSize: CGFloat = 25.0
            let bigTextSize: CGFloat = 55.0
            
            BackGroundView(color: backGroundColor)
            VStack {
                TitleView(textSize: bigTextSize, titleContent: titleText,
                          textColor: textColor)
                ZStack(alignment: .center) {
                    TextView(size: smallTextSize,
                             text: middleText ?? "",
                             textColor: textColor)
                        
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                .frame(width: .infinity, height: 100)
                DataView(label1: subTitleText1,
                         label2: subTitleText2,
                         data1: subTitleValue1,
                         data2: subTitleValue2,
                         textSize: smallTextSize,
                         textColor: textColor)
            }
        }
    }
}

/// This view is the background color of the screens. It is a single Rectangle that can be any color.
struct BackGroundView: View {
    var color: Color
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .ignoresSafeArea()
        
    }
}

/// This view is the text view shown in all places where text is shown
struct TextView: View {
    var size: CGFloat
    var text: String
    var textColor: Color
    var body: some View {
        Text("\(text)")
            .font(.system(size: size,
                          weight: .bold,
                          design: .default))
            
            .foregroundColor(textColor)
        
    }
}

/// This view is the big title text shown in all the screens.
struct TitleView: View {
    var textSize: CGFloat
    var titleContent: String
    var textColor: Color
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                //Add an Icon here if you need to
                
                TextView(size: textSize, text:  titleContent, textColor: textColor)
                    .padding(.bottom, 50)
            }
        }
    }
}

/// This view is for the formatting of the two lines of data at the bottom of all the screens
struct DataView: View {
    var label1: String
    var label2: String
    var data1: String
    var data2: String
    var textSize: CGFloat
    var textColor: Color
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextView(size: textSize, text: "\(label1) |  \(data1)", textColor: textColor).padding()
                TextView(size: textSize, text: "\(label2)  |  \(data2)", textColor: textColor).padding()
            }
            .padding(.bottom, 120)
        }
    }
}

/// This view is for the three rectangles at the top of the screen on Screen 2
struct ThreeDots: View {
    var color: Color
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(color)
                    .frame(width: 50, height: 50, alignment: .center)
                
            }
        }
    }
}

struct ScreenOne: View {
    var bestScore: Int?
    var bestLastAverageScore: Int?
    var body: some View {
        Template(backGroundColor: ReactionTimeView().blueColor,
                 titleText: "Tap to Start!",
                 subTitleText1: "Best",
                 subTitleValue1: "\(bestScore ?? 0)ms",
                 subTitleText2: "Last",
                 subTitleValue2: "\(bestLastAverageScore ?? 0)ms",
                 textColor: ReactionTimeView().textPrimaryColor,
                 middleText: "When the red box turns green, tap as quickly as you can.")
    }
}

struct ScreenTwo: View {
    var averageScore: Int?
    var numOfTries: Int?
    var maxNumOfTries: Int
    var body: some View {
        ZStack {
            Template(backGroundColor: ReactionTimeView().redColor,
                     titleText: "Wait for green...",
                     subTitleText1: "Average",
                     subTitleValue1: "\(averageScore ?? 0)ms",
                     subTitleText2: "Tries",
                     subTitleValue2: "\(numOfTries ?? 0) of \(maxNumOfTries)",
                     textColor: ReactionTimeView().textPrimaryColor)
            VStack {
                ThreeDots(color: ReactionTimeView().textPrimaryColor)
                    .padding(.top, 145)
                Spacer()
            }
        }
    }
}

struct ScreenThree: View {
    var averageScore: Int?
    var numOfTries: Int?
    var maxNumOfTries: Int
    var body: some View {
        ZStack {
            Template(backGroundColor: ReactionTimeView().greenColor,
                     titleText: "Tap!",
                     subTitleText1: "Average",
                     subTitleValue1: "\(averageScore ?? 0)ms",
                     subTitleText2: "Tries",
                     subTitleValue2: "\(numOfTries ?? 0) of \(maxNumOfTries)",
                     textColor: ReactionTimeView().textPrimaryColor,
                     middleText: nil)
            VStack {
                Image(systemName: "clock")
                    .font(.system(size: 150,
                                  weight: .bold,
                                  design: .default))
                    .foregroundColor(ReactionTimeView().textPrimaryColor)
                    .padding(.top, 100)
                Spacer()
            }
        }
    }
}

struct ScreenFour: View {
    var score: Int?
    var averageScore: Int?
    var numOfTries: Int?
    var maxNumOfTries: Int
    var body: some View {
        ZStack {
            Template(backGroundColor: ReactionTimeView().blueColor,
                     titleText: "\(score ?? 0)ms",
                     subTitleText1: "Average",
                     subTitleValue1: "\(averageScore ?? 0)ms",
                     subTitleText2: "Tries",
                     subTitleValue2: "\(numOfTries ?? 0) of \(maxNumOfTries)",
                     textColor: ReactionTimeView().textPrimaryColor,
                     middleText: nil)
            VStack {
                Image(systemName: "clock")
                    .font(.system(size: 150,
                                  weight: .bold,
                                  design: .default))
                    .foregroundColor(ReactionTimeView().textPrimaryColor)
                    .padding(.top, 100)
                Spacer()
            }
        }
    }
}


/// This is for the content preview screen
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionTimeView()
    }
}

// ⌥ + ⌘ + ← to fold
// ⌥ + ⌘ + → to unfold
