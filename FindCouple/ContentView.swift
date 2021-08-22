//
//  ContentView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import GoogleMobileAds
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        StartView(storeManager: storeManager)
            .onAppear(perform: {
                model.gameBehavior.score = UserDefaults.standard.integer(forKey: "Score")
                
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            })
    }
}
