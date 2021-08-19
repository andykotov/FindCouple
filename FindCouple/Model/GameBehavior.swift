//
//  GameMode.swift
//  FindCouple
//
//  Created by mr. Hakoda on 15.08.2021.
//

import Foundation
import SwiftUI

struct GameBehavior {
    var localScore = 0
    var score = 0
    var level = 1
    var timeOfLevel = 0.5
    var geo = String()
    
    var url = "https://www.google.com.ua/"
    var isLoading = false
    var canGoBack = false
    var shouldGoBack = false
    var title: String = ""
}
