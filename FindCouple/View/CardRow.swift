//
//  CardRow.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import SwiftUI

struct CardRow: View {
    @EnvironmentObject var model: Model
    
    @Binding var isOpened: Bool
    @Binding var matchArray: [String]
//    @Binding var cardModel: [[CardModel]]
    var array: [CardModel]
    @Binding var localScore: Double
    @Binding var progressValue: Double
    @Binding var isGameOver: Bool
    @Binding var nextLevel: Bool
    
    var geo: GeometryProxy
//    var indexArray: Int
    
    var body: some View {
        HStack {
            ForEach(array, id: \.self) { card in
                Card(isOpened: $isOpened, matchArray: $matchArray, array: array, card: card, localScore: $localScore, progressValue: $progressValue, isGameOver: $isGameOver, nextLevel: $nextLevel, cardWidth: CGFloat(Int(geo.size.width) / model.cardBehavior.countCardRow - 20), cardHeight: CGFloat(Int(geo.size.width) / model.cardBehavior.countCardRow - 20), geo: geo).environmentObject(model)
            }
        }
        
    }
}
