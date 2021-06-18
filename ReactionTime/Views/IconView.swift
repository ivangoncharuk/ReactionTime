//
//  IconView.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/17/21.
//

import SwiftUI

struct IconView: View {
    let textPrimaryColor = ReactionTimeGameView().textPrimaryColor
    var curScreenSt: ScreenStates
    var body: some View {
        switch curScreenSt {
        case .WAIT:
            ThreeDots(color: textPrimaryColor)
                .padding(.bottom, 400)
        case .TAP, ScreenStates.self.SCORE:
            Image(systemName: "clock")
                .font(.system(size: 140, weight: .bold, design: .default))
                .foregroundColor(textPrimaryColor)
                .padding(.bottom, 400)
        case .TOO_SOON, .TOO_LATE:
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 140, weight: .bold, design: .default))
                .foregroundColor(textPrimaryColor)
                .padding(.bottom, 400)
        case .START:
            Image(systemName: "bolt.fill")
                .font(.system(size: 140, weight: .bold, design: .default))
                .foregroundColor(textPrimaryColor)
                .padding(.bottom, 400)
        default:
            EmptyView()
        }
    }
}
