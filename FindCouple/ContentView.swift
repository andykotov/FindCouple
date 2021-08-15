//
//  ContentView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()
    
    var body: some View {
        StartView().environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
