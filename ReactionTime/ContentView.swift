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
            BackGround1()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackGround1: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.1610118449, green: 0.5290118456, blue: 0.8145868182, alpha: 1)))
            .ignoresSafeArea()
    }
}
