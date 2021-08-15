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
                Text("Ваш счёт")
                    .font(.subheadline)
                Text("\(model.gameModel.score)")
                    .font(.subheadline)
                
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
