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
        StartScreen()
    }
}

struct StartScreen: View {
    var body: some View {
        ZStack {
            
            let smallTextSize: CGFloat = 25.0
            let bigTextSize: CGFloat = 55.0
            let backGroundColor: Color = Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1))
            
            BackGroundView(color: backGroundColor)
            VStack {
                Spacer()
                
                ZStack(alignment: .top) {
                    VStack {
                        Spacer()
                        //Add an Icon here if you need to
                        TextView(size: bigTextSize, text:  "Tap to Start!")
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
                        TextView(size: smallTextSize, text: "Best  |  0ms").padding()
                        TextView(size: smallTextSize, text: "Last  |  0ms").padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionTimeView()
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
