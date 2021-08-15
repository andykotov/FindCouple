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
    
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var indexArray: Int
    var cardIndex: Int
    
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
                            localScore += 1
                            print(localScore)
                            if Int(localScore) == (model.cardBehavior.countCardRow * model.cardBehavior.countCardRow) - 1 {
                                localScore = 0.0
                                resetProgressBar()
                                DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeAllCardsDelay) {
                                    startRound()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeAllCardsDelay) {
                                        isOpened = false
                                        startProgressBar()
                                    }
                                }
                            }
                //            card.isLocalOpened = true
                        } else {
                            card.isLocalOpened = false
                            card.isMatched = false
                            matchArray = [String()]
//                            localScore -= 1
                        }
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
    
    func startRound() {
        var cardModelArray = [CardModel()]
        let array = model.cardBehavior.finalArray
        for index in 0..<array.count {
            var cardModel = CardModel()
            cardModel.id = index
            cardModel.card = array[index]
            cardModel.isLocalOpened = false
            cardModelArray.append(cardModel)
        }
        let filtered = cardModelArray.filter({ $0.card != ""})
        let chankedArray = filtered.chunked(into: model.cardBehavior.countCardRow)
        cardModel = chankedArray
    }
    
    func startProgressBar() {
        var runCount = 0.0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.progressValue += 0.0166
            runCount += 0.0166

            if runCount > 1.0 {
                timer.invalidate()
                resetProgressBar()
                gameOver()
            }
        }
    }
    
    func resetProgressBar() {
        self.progressValue = 0.0
    }
    
    func gameOver() {
        isOpened = false
        matchArray = [String()]
        presentationMode.wrappedValue.dismiss()
        isGameOver = true
    }
}
