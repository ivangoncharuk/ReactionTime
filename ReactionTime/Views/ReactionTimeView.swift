//
//  ContentView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI


struct ReactionTimeView: View {
    @StateObject private var reactionTimeViewModel = ReactionTimeViewModel()
    
    var body: some View {
        StartScreen(backGroundColor: Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1)),
                    titleText: "Tap to Start!",
                    subTitleText1: "Best",
                    subTitleValue1: "0ms",
                    subTitleText2: "Last",
                    subTitleValue2: "0ms")
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
struct StartScreen: View {
    var backGroundColor: Color
    var titleText: String
    var subTitleText1: String
    var subTitleValue1: String
    var subTitleText2: String
    var subTitleValue2: String
    
    var body: some View {
        ZStack {
            let smallTextSize: CGFloat = 25.0
            let bigTextSize: CGFloat = 55.0
            
            BackGroundView(color: backGroundColor)
            VStack {
                Spacer()
                
                ZStack(alignment: .top) {
                    VStack {
                        Spacer()
                        //Add an Icon here if you need to
                        TextView(size: bigTextSize, text:  titleText)
                            .padding(.bottom, 50)
                    }
                }
                ZStack(alignment: .center) {
                    TextView(size: smallTextSize,
                             text: "When the read box turns green, tap as quickly as you can.")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                .frame(width: .infinity, height: 130)
                
                ZStack(alignment: .bottom) {
                    VStack {
                        TextView(size: smallTextSize, text: "\(subTitleText1) |  \(subTitleValue1)").padding()
                        TextView(size: smallTextSize, text: "\(subTitleText2)  |  \(subTitleValue2)").padding()
                    }
                    .padding(.bottom, 150)
                }
            }
        }
    }
}

/**
 This view is the background color. It is a single Rectangle that can be any color.
 */
struct BackGroundView: View {
    var color: Color
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .ignoresSafeArea()
    }
}

struct TextView: View {
    var size: CGFloat
    var text: String
    var body: some View {
        Text("\(text)")
            .font(.system(size: size,
                          weight: .bold,
                          design: .default))
            
            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
            
    }
}

struct ThreeDots: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 50, height: 50, alignment: .center)
            }
        }
    }
}

struct BasicScreen: View {
    var body: some View {
        ZStack {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionTimeView()
    }
}


