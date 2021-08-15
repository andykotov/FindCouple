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
    @Binding var cardModel: [[CardModel]]
    @Binding var rowArray: [CardModel]
    @Binding var localScore: Double
    @Binding var progressValue: Float
    @Binding var isGameOver: Bool
    
    var geo: GeometryProxy
    var indexArray: Int
    
    var body: some View {
        HStack {
            ForEach(0..<rowArray.count) { cardIndex in
                Card(isOpened: $isOpened, matchArray: $matchArray, cardModel: $cardModel, card: $rowArray[cardIndex], localScore: $localScore, progressValue: $progressValue, isGameOver: $isGameOver, cardWidth: CGFloat(Int(geo.size.width) / model.cardBehavior.countCardRow - 20), cardHeight: CGFloat(Int(geo.size.width) / model.cardBehavior.countCardRow - 20), indexArray: indexArray, cardIndex: cardIndex)
            }
        }
        
    }
}
