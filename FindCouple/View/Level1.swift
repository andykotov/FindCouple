//
//  Level1.swift
//  FindCouple
//
//  Created by mr. Hakoda on 15.08.2021.
//

import SwiftUI

struct Level1: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: Model
    
    @Binding var cardModel: [[CardModel]]
    @Binding var matchArray: [String]
    @Binding var isGameOver: Bool
    @Binding var localScore: Double
    
    var geo: GeometryProxy
    
    @State private var isOpened = true
    @State var progressValue: Float = 0.0
    
    var body: some View {
        VStack {
            ProgressBar(value: $progressValue, geo: geo).frame(height: 2)
                .padding(.horizontal, 30)
            
            VStack {
                ForEach(0..<cardModel.count) { indexArray in
                    CardRow(isOpened: $isOpened, matchArray: $matchArray, cardModel: $cardModel, rowArray: $cardModel[indexArray], localScore: $localScore, progressValue: $progressValue, isGameOver: $isGameOver, geo: geo, indexArray: indexArray)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            
            Spacer()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeAllCardsDelay) {
                isOpened = false
                startProgressBar()
            }
        })
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
