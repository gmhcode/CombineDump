//
//  FancyScoreView3.swift
//  SwiftUI-ObservableObject
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct FancyScoreView3: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack {
            Text("\(self.userSettings.score)")
            Button("Increment Score") {
                self.userSettings.score += 1
            }.padding()
            .background(Color.green)
        }.padding()
        .background(Color.orange)
    }
}

struct FancyScoreView_Previews3: PreviewProvider {
    static var previews: some View {
        FancyScoreView3()
    }
}
