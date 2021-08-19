//
//  GameStore.swift
//  FindCouple
//
//  Created by mr. Hakoda on 17.08.2021.
//

import SwiftUI

struct GameStore: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Отключить рекламу")
                        .font(.headline)
                    
                    Text("Вся реклама в приложении будет отключена раз и навсегда")
                        .font(.subheadline)
                        .padding(.top, 10)
                }
                .padding(.trailing, 10)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "cart")
                        .foregroundColor(Color.white)
                        .imageScale(.large)
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Замороить время")
                        .font(.headline)
                    
                    Text("После активации время будет заморожено на 30 секунд")
                        .font(.subheadline)
                        .padding(.top, 10)
                }
                .padding(.trailing, 10)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "timer")
                        .foregroundColor(Color.white)
                        .imageScale(.large)
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Пропустить уровень")
                        .font(.headline)
                    
                    Text("После активации текущий уровень будет завершен автоматически")
                        .font(.subheadline)
                        .padding(.top, 10)
                }
                .padding(.trailing, 10)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.forward.circle")
                        .foregroundColor(Color.white)
                        .imageScale(.large)
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding()
                }
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            
            Divider()
            
            Spacer()
        }
        .navigationBarTitle("Магазин", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading:
//            Button(action: {
//                self.isPresented = false
//            }){
//            Image(systemName: "arrow.left")
//                .imageScale(.medium)
//                .frame(width: 24, height: 24, alignment: .center)
//                .padding([.vertical, .trailing])
//            }
//        )
    }
}