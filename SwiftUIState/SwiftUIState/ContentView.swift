//
//  ContentView.swift
//  SwiftUIState
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = "John"
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .padding()
            Button(action: {
                self.name = "Greg"
            }) {
                Text("Change name")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
