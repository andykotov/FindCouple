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
    var cardModel = [[CardModel()]]
    
    var finalArray: [String] {
        var array = cardArray
        array.shuffle()
        let trimmedArray = array.prefix((countCardRow * countCardRow) / 2)
        var clonedArray = trimmedArray + trimmedArray
        clonedArray.shuffle()
        return Array(clonedArray)
    }
}

struct CardModel: Hashable {
    var id = Int()
    var card = String()
    var isLocalOpened = Bool()
    var isMatched = Bool()
}
