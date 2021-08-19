//
//  ContentView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import GoogleMobileAds
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()
    
    var body: some View {
        StartView().environmentObject(model)
            .onAppear(perform: {
                model.gameModel.score = UserDefaults.standard.integer(forKey: "Score")
                
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
