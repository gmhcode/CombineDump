//
//  FancyScoreView.swift
//  SwiftUI-ObservableObject
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct FancyScoreView: View {
    
    @Binding var score: Int
    
    var body: some View {
        VStack {
            Text("\(self.score)")
            Button("Increment Score") {
                self.score += 1
            }.padding()
            .background(Color.green)
        }.padding()
        .background(Color.orange)
    }
}

struct FancyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FancyScoreView(score: .constant(0))
    }
}
