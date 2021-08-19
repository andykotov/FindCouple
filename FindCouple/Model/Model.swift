//
//  Model.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import Foundation

public class Model: ObservableObject {
    @Published var cardBehavior = CardBehavior()
    @Published var gameBehavior = GameBehavior()
    
}
