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
    
    @Binding var isPresented: Bool
    @Binding var matchArray: [String]
    @Binding var isGameOver: Bool
    @Binding var localScore: Double
    
    @StateObject var storeManager: StoreManager
    
    @State var isOpened = true
    @State var progressValue: Double = 0.0
    @State var nextLevel = false
    @State var skipLevel = false
    @State var runCount = 0.0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    if UserDefaults.standard.bool(forKey: "AdditionalTime30") {
                        Button(action: {
                            model.gameBehavior.isTimeIncreased = true
                            UserDefaults.standard.setValue(false, forKey: "AdditionalTime30")
                        }) {
                            Image(systemName: "timer")
                                .foregroundColor(Color.white)
                                .imageScale(.large)
                                .frame(width: 24, height: 24, alignment: .center)
                                .padding()
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                    } else {
                        Button(action: {
                        }) {
                            Image(systemName: "timer")
                                .foregroundColor(Color.white)
                                .imageScale(.large)
                                .frame(width: 24, height: 24, alignment: .center)
                                .padding()
                        }
                        .background(Color.gray)
                        .cornerRadius(10)
                        .disabled(true)
                    }
                    
                    Text("\(Int(localScore / 2)) / \((model.cardBehavior.countCardRow * model.cardBehavior.countCardRow) / 2)")
                        .font(.title)
                        .padding(.horizontal, 20)
                    
                    if UserDefaults.standard.bool(forKey: "SkipLevel1") {
                        Button(action: {
                            skipLevel = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                toNextLevel()
                            }
                            UserDefaults.standard.setValue(false, forKey: "SkipLevel1")
                        }) {
                            Image(systemName: "arrow.forward.circle")
                                .foregroundColor(Color.white)
                                .imageScale(.large)
                                .frame(width: 24, height: 24, alignment: .center)
                                .padding()
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                    } else {
                        Button(action: {
                        }) {
                            Image(systemName: "arrow.forward.circle")
                                .foregroundColor(Color.white)
                                .imageScale(.large)
                                .frame(width: 24, height: 24, alignment: .center)
                                .padding()
                        }
                        .background(Color.gray)
                        .cornerRadius(10)
                        .disabled(true)
                    }
                }
                .padding(.vertical, 20)
                
                ProgressBar(value: $progressValue, geo: geo).frame(height: 4)
                    .padding(.horizontal, 30)
                
                VStack {
                    ForEach(model.cardBehavior.cardModel, id: \.self) { array in
                        CardRow(isOpened: $isOpened, matchArray: $matchArray, array: array, localScore: $localScore, progressValue: $progressValue, isGameOver: $isGameOver, nextLevel: $nextLevel, geo: geo).environmentObject(model)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                
                if nextLevel {
                    Button(action: {
                        toNextLevel()
                    }) {
                        Text("Продолжить")
                            .padding()
                            .foregroundColor(Color.white)
                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
                
                if !UserDefaults.standard.bool(forKey: "DisableAdvertise") {
                    BannerView()
                }
                
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Уровень \(model.gameBehavior.level)", displayMode: .inline)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeAllCardsDelay) {
                isOpened = false
                runCount = 0.0
                startProgressBar()
            }
        })
    }
    
    /// Takes the game to the next level
    func toNextLevel() {
        nextLevel = false
        skipLevel = false
        model.gameBehavior.localScore += 1
        model.gameBehavior.level += 1
        localScore = 0.0
        
        if model.gameBehavior.level == 2 {
            model.gameBehavior.timeOfLevel = 0.5
        } else if model.gameBehavior.level == 3 {
            model.gameBehavior.timeOfLevel = 1.0
            model.cardBehavior.countCardRow = 4
        } else if model.gameBehavior.level == 5 {
            model.cardBehavior.closeAllCardsDelay = 2.0
        } else if model.gameBehavior.level == 6 {
            model.gameBehavior.timeOfLevel = 0.5
        } else if model.gameBehavior.level == 7 {
            model.gameBehavior.timeOfLevel = 1.5
            model.cardBehavior.closeAllCardsDelay = 3.0
            model.cardBehavior.countCardRow = 5
        } else if model.gameBehavior.level == 9 {
            model.gameBehavior.timeOfLevel = 1.0
        }
        
        nextRound()
        resetProgressBar()
        isOpened = true
        DispatchQueue.main.asyncAfter(deadline: .now() + model.cardBehavior.closeAllCardsDelay) {
            isOpened = false
            runCount = 0.0
            startProgressBar()
        }
    }
    
    /// The level time indicator starts its movement
    func startProgressBar() {
        Timer.scheduledTimer(withTimeInterval: model.gameBehavior.timeOfLevel, repeats: true) { timer in
            self.progressValue += 0.0166
            runCount += 0.0166
            
            if model.gameBehavior.isTimeIncreased {
                timer.invalidate()
                model.gameBehavior.timeOfLevel += 0.5
                startProgressBar()
                model.gameBehavior.isTimeIncreased = false
            }
            
            if nextLevel || skipLevel {
                timer.invalidate()
                resetProgressBar()
            }

            if runCount > 1.0 && !nextLevel {
                timer.invalidate()
                gameOver()
                resetProgressBar()
            }
        }
    }
    
    /// The level time indicator is reset
    func resetProgressBar() {
        self.runCount = 0.0
        self.progressValue = 0.0
    }
    
    /// End of the game after the end of the round time
    func gameOver() {
        model.gameBehavior.score = UserDefaults.standard.integer(forKey: "Score")
        
        if model.gameBehavior.localScore > model.gameBehavior.score {
            UserDefaults.standard.set(model.gameBehavior.localScore, forKey: "Score")
            model.gameBehavior.score = model.gameBehavior.localScore
        }
        
        localScore = 0.0
        matchArray = [String()]
        progressValue = 0.0
        isOpened = false
        isPresented = false
        isGameOver = true
    }
    
    /// Launching the next round
    func nextRound() {
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
        model.cardBehavior.cardModel = chankedArray
    }
}
