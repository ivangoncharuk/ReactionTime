//
//  ContentView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            StartScreen()
        }
    }
}

struct BackGround1: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1)))
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

struct StartScreen: View {
    var body: some View {
        ZStack {
            BackGround1()
            VStack {
                let smallTextSize: CGFloat = 30.0
                TextView(size: 60.0, text:  "Tap to Start!")
                    .padding(.vertical, 30)
                TextView(size: smallTextSize, text: "When the read box turns green, tap as quickly as you can.")
                    .multilineTextAlignment(.center)
                
                TextView(size: smallTextSize, text: "Best | 0ms")
                    .padding()
                TextView(size: smallTextSize, text: "Last | 0ms")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
