//
//  ContentView.swift
//  SwiftUI-ObservableObject
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
   
    
    var body: some View {
        VStack {
            EnviromentObjectExample1()
        }
    }
}
struct ObservableObject1: View {
    @ObservedObject var fancyTimer = FancyTimer()
    
    var body: some View {
        Text("\(self.fancyTimer.value)")
            .font(.largeTitle)
            .padding()
    }
}
struct ObservableObject2: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        VStack {
            Text("\(self.userSettings.score)")
                .font(.largeTitle)
            Button("Increment Score") {
                self.userSettings.score += 1
            }
            FancyScoreView(score: self.$userSettings.score)
        }
           
    }
}
//environment object is basically like a static var
struct EnviromentObjectExample1: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        VStack {
            Text("\(self.userSettings.score)")
                .font(.largeTitle)
            Button("Increment Score") {
                self.userSettings.score += 1
            }
            FancyScoreView3()
        }
           
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
