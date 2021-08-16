//
//  CardModel.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import Combine
import Foundation
import SwiftUI

struct CardBehavior {
    var closeCardDelay: Double = 1.0
    var closeAllCardsDelay: Double = 3.0
    var countCardRow: Int = 3
    var cardArray = ["banana", "banana2", "fruit", "fruit2", "fruit3", "harvest", "juice", "leaf", "milk", "shake", "split", "split2", "split3", "split4", "split5", "split6", "split7"]
//    var matrix = [0, 1, 2, 3, 10, 11, 12, 13, 20, 21, 22, 23, 30, 31, 32, 33]
//    @State var cardModelFinal = [[CardModel()]]
    
    var finalArray: [String] {
        var array = cardArray
        array.shuffle()
//        var double = Double(countCardRow * countCardRow) / 2
//        double.round(.up)
        let trimmedArray = array.prefix((countCardRow * countCardRow) / 2)
        var clonedArray = trimmedArray + trimmedArray
        clonedArray.shuffle()
        return Array(clonedArray)
    }
    
//    var cardModel: [[CardModel]] {
//        var cardModelArray = [CardModel()]
//        let array = finalArray
//        for index in 0..<array.count {
//            var cardModel = CardModel()
//            cardModel.id = index
//            cardModel.card = array[index]
//            cardModel.isLocalOpened = false
//            cardModelArray.append(cardModel)
//        }
//        let filtered = cardModelArray.filter({ $0.card != ""})
//        let chankedArray = filtered.chunked(into: countCardRow)
//        return chankedArray
//    }
}

struct CardModel: Hashable {
    var id = Int()
    var card = String()
    var isLocalOpened = Bool()
    var isMatched = Bool()
}
