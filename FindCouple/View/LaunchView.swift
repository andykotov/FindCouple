//
//  LaunchView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 03.09.2021.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Image("launchScreenImage")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
