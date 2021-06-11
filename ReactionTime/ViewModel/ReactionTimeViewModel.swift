//
//  ReactionTimeViewModel.swift
//  ReactionTime
//
//  Created by Ivan Goncharuk on 6/11/21.
//

import SwiftUI

class ReactionTimeViewModel: ObservableObject {
    @Published var tries: Int = 0
    @Published var reactionTimeInMS: Double = 0.000
    @Published var avgTimeInMS: Double = 0.000
    @Published var lastAvg: Double? //optional because there is no lastAvg on the first playthrough
    
    
}
