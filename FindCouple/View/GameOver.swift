//
//  GameOver.swift
//  FindCouple
//
//  Created by mr. Hakoda on 15.08.2021.
//

import SwiftUI

struct GameOver: View {
    @EnvironmentObject var model: Model
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Время вышло")
                    .font(.title)
                    .padding(10)
                Text("Ваш текущий счёт")
                Text("\(model.gameModel.localScore)")
                    .font(.title)
                    .padding(10)
                Text("Ваш лучший счёт")
                Text("\(model.gameModel.score)")
                    .font(.title)
                    .padding(.vertical, 10)
                
                Image("leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
                
                Text("Поробуйте ещё раз!")
                    .padding()
            }
            .padding()
            
            Spacer()
        }
    }
}
