//
//  StartScreen.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var model: Model
    
    @State private var isShowingGameView = false
    @State private var isShowingGameStore = false
    @State var matchArray = [String()]
//    @State var cardModel = [[CardModel()]]
    @State var isGameOver = false
    @State var localScore = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    Text("Find Couple")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    if model.gameModel.score != 0 {
                        Text("Ваш лучший счёт")
                            .padding(.top, 10)
                        Text("\(model.gameModel.localScore > model.gameModel.score ? model.gameModel.localScore : model.gameModel.score)")
                            .font(.title)
                            .padding(.top, 10)
                    }
                }
                
                Image("split5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                
                Button(action: {
                    startRound()
                    self.isShowingGameView = true
                }) {
                    Text("Начать игру")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                }
                .frame(width: 200)
                .background(Color.green)
                .cornerRadius(10)
                
                Button(action: {
                    
                    self.isShowingGameStore = true
                }) {
                    Text("Магазин")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                }
                .frame(width: 200)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 10)
                
                NavigationLink(destination: GameView(isPresented: $isShowingGameView, matchArray: $matchArray, isGameOver: $isGameOver, localScore: $localScore).environmentObject(model), isActive: $isShowingGameView) { EmptyView() }
                
                NavigationLink(destination: GameStore(isPresented: $isShowingGameStore), isActive: $isShowingGameStore) { EmptyView() }
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                
                Spacer()
            }
            .navigationBarTitle("Назад")
            .navigationBarHidden(true)
            .onAppear(perform: {
//                startRound()
            })
            .sheet(isPresented: $isGameOver, onDismiss: resetGame) {
                GameOver(isPresented: $isGameOver).environmentObject(model)
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
        model.cardBehavior.cardModel = chankedArray
    }
    
    func resetGame() {
        model.gameModel.level = 1
        model.cardBehavior.closeAllCardsDelay = 3.0
        model.cardBehavior.countCardRow = 3
        model.gameModel.timeOfLevel = 0.5
        
        model.cardBehavior.cardModel = [[CardModel()]]
        startRound()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
