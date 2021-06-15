//
//  ContentView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI


struct ReactionTimeView: View {
    @ObservedObject var vM = ReactionTimeViewModel()
    
    
    let redColor: Color         = Color(#colorLiteral(red: 0.806209743, green: 0.1509520113, blue: 0.2106329799, alpha: 1))
    let greenColor: Color       = Color(#colorLiteral(red: 0.29623577, green: 0.8585592508, blue: 0.4167816639, alpha: 1))
    let blueColor: Color        = Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1))
    let textPrimaryColor: Color = Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    let descriptionText: String = "When the red box turns green, tap as quickly as you can."
    
    var bgColor: (Int) -> Color = { x in
        let rTV = ReactionTimeView()
        switch x {
        case 1:
            return rTV.blueColor
        case 2:
            return rTV.redColor
        case 3:
            return rTV.blueColor
        case 4:
            return rTV.greenColor
        case 5:
            return rTV.blueColor
        default:
            return rTV.blueColor
        }
    }
    
    var body: some View {
        let bestScore = vM.model.bestScore
        let averageScore = vM.model.avgTimeScoreInMS
        let last = vM.model.lastAvg
        let css = vM.model.currentScreenState
        ZStack {
            let titleText: (Int) -> String = {x in
                switch x {
                case 1:
                    return "Tap to Start!"
                case 2:
                    return "Wait for Green"
                case 3:
                    return "Too soon :("
                case 4:
                    return "Tap!"
                case 5:
                    return String(vM.model.currentReactionTimeScoreInMS) + "ms"
                default:
                    return "default text"
                }
            }
            
            switch css {
            case 2:
                ThreeDots(color: textPrimaryColor)
                    .padding(.bottom, 400)
            case 3, 5:
                Image(systemName: "clock")
                    .font(.system(size: 140, weight: .bold, design: .default))
                    .foregroundColor(textPrimaryColor)
                    .padding(.bottom, 400)
            case 4:
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 140, weight: .bold, design: .default))
                    .foregroundColor(textPrimaryColor)
                    .padding(.bottom, 400)
            default:
                EmptyView()
            }
            Template(backGroundColor: bgColor(css),
                     titleText: titleText(css),
                     subTitleText1:     (css == 1) ? "Best Score" : "Average",
                     subTitleValue1:    (css == 1) ? "\(bestScore ?? 0)ms" : "\(averageScore ?? 0)ms",
                     subTitleText2:     (css == 1) ? "Last Average" : "Tries",
                     subTitleValue2:    (css == 1) ? "\(last ?? 0)ms" : "\(vM.model.numOfTries) of \(vM.model.maxNumOfTries)",
                     textColor: textPrimaryColor,
                     middleText: (css == 1) ? descriptionText : (css == 3) ? "Tap to try again" : "")
                .onTapGesture {
                    vM.tappedTheScreen()
                }
            
            VStack {
                Text(String(vM.model.currentReactionTimeScoreInMS) + "ms")
                    .padding(.top, 700)
                    .font(.system(size: 40, weight: .black, design: .monospaced))
                Text("css: \(vM.model.currentScreenState)")
                    .padding()
                    .font(.system(size: 20, weight: .black, design: .monospaced))
            }
            
        }
    }
    
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
                    .frame(width: UIScreen.main.bounds.width, height: 100)
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
        @ObservedObject var vModel = ReactionTimeViewModel()
        var label1: String
        var label2: String
        var data1: String
        var data2: String
        var textSize: CGFloat
        var textColor: Color
        var body: some View {
            ZStack(alignment: .bottom) {
                VStack {
                    if vModel.model.currentScreenState != 3 {
                        TextView(size: textSize, text: "\(label1)  |  \(data1)", textColor: textColor).padding()
                        TextView(size: textSize, text: "\(label2)  |  \(data2)", textColor: textColor).padding()
                    }
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
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(color)
                        .frame(width: 50, height: 50, alignment: .center)
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
}
