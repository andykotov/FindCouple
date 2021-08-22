//
//  GameStore.swift
//  FindCouple
//
//  Created by mr. Hakoda on 17.08.2021.
//

import SwiftUI

struct GameStore: View {
    @Binding var isPresented: Bool
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        List(storeManager.myProducts, id: \.self) { product in
            HStack {
                VStack(alignment: .leading) {
                    Text(product.localizedTitle)
                        .font(.headline)
                    
                    Text(product.localizedDescription)
                        .font(.subheadline)
                        .padding(.vertical, 1)
                    
                    Text("Купить за \(product.price) $")
                }
                .padding(.trailing, 10)
                
                Spacer()
                
                if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding()
                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    .disabled(true)
                    
                } else {
                    Button(action: {
                        storeManager.purchaseProduct(product: product)
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
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .navigationBarTitle("Магазин", displayMode: .inline)
//        .toolbar(content: {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    //Restore products already purchased
//                }) {
//                    Text("Восстановить")
//                }
//            }
//        })
    }
}
