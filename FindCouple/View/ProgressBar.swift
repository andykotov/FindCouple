//
//  ProgressBar.swift
//  FindCouple
//
//  Created by mr. Hakoda on 15.08.2021.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    var geo: GeometryProxy
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geo.size.width - 60 , height: 2)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value) * (geo.size.width - 60), geo.size.width - 60), height: 2)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}
