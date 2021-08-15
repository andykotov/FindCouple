//
//  GameView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

import SwiftUI

struct GameView: View {
    @EnvironmentObject var model: Model
    
    @Binding var cardModel: [[CardModel]]
    @Binding var matchArray: [String]
    @Binding var isGameOver: Bool
    @Binding var localScore: Double
    
    var body: some View {
        GeometryReader { geo in
            Level1(cardModel: $cardModel, matchArray: $matchArray, isGameOver: $isGameOver, localScore: $localScore, geo: geo)
        }
        .navigationBarBackButtonHidden(true)
    }
}
