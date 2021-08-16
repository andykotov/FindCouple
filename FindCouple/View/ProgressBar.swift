//
//  ProgressBar.swift
//  FindCouple
//
//  Created by mr. Hakoda on 15.08.2021.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    var geo: GeometryProxy
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geo.size.width - 60 , height: 4)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemYellow))
                
                Rectangle().frame(width: min(CGFloat(self.value) * (geo.size.width - 60), geo.size.width - 60), height: 4)
                    .foregroundColor(Color(UIColor.systemOrange))
                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}
