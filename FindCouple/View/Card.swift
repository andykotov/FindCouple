//
//  Card.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import SwiftUI

struct Card: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: Model
    
    @Binding var isOpened: Bool
    @Binding var matchArray: [String]
    @Binding var cardModel: [[CardModel]]
    @Binding var card: CardModel
    @Binding var localScore: Double
    @Binding var progressValue: Float
    @Binding var isGameOver: Bool
    @Binding var nextLevel: Bool
    
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var indexArray: Int
    var cardIndex: Int
    var geo: GeometryProxy
    
    var body: some View {
        VStack {
            if isOpened || card.isLocalOpened || card.isMatched {
                Button(action: {
                
                }){
                    Image(card.card)
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardWidth / 1.5, height: cardHeight / 1.5, alignment: .center)
                }
                .frame(width: cardWidth, height: cardHeight, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
            } else {
                Button(action: {
                    card.isLocalOpened = true
                    matchArray.append(card.card)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeCardDelay) {
                        if matchArray.filter({ $0 == card.card }).count == 2 {
                            for row in cardModel {
                                for item in row {
                                    if item.card == card.card {
                                        guard let indexRow = cardModel.firstIndex(where: { $0 == row }) else { return }
                                        guard let indexItem = cardModel[indexRow].firstIndex(where: { $0 == item }) else { return }
                                        cardModel[indexRow][indexItem].isMatched = true
                                    }
                                }
                            }
                        } else {
                            card.isLocalOpened = false
                            matchArray = [String()]
                        }
                    }
                    localScore = 0
                    
                    for row in cardModel {
                        for item in row {
                            if item.isLocalOpened || item.isMatched {
                                localScore += 1
                            }
                        }
                    }
                    
                    if Int(localScore) == (model.cardBehavior.countCardRow * model.cardBehavior.countCardRow) {
                        nextLevel = true
                    }
                    
                }){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
    //                    .frame(width: cardWidth / 1.5, height: cardHeight / 1.5, alignment: .center)
                }
                .frame(width: cardWidth, height: cardHeight, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
            }
        }
    }
    
}
