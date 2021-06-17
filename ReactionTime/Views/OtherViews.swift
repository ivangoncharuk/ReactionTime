//
//  OtherViews.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/17/21.
//

import SwiftUI

/// This view is for the template for each screen.
struct TemplateScreenView: View {
    //TODO: Only display DataView when we have data for the start screen.
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
                BigTextView(textSize: bigTextSize, titleContent: titleText,
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
struct BigTextView: View {
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
                if ReactionTimeGameView().vM.model.currentScreenState != .TOO_SOON {
                    TextView(size: textSize, text: "\(label1)  |  \(data1)", textColor: textColor)
                        .padding()
                    TextView(size: textSize, text: "\(label2)  |  \(data2)", textColor: textColor)
                        .padding()
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


 
 struct TestingView: View {
     var score: Int
     var css: String
     var body: some View {
         VStack {
             Text(String(score) + "ms")
                 .padding(.top, 700)
                 .font(.system(size: 40, weight: .black, design: .monospaced))
         }
     }
 }
 

