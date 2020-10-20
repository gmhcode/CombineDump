//
//  ContentView.swift
//  Hello-Binding
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    // MARK: - textField Binding
    var body: some View {
        VStack {
            Text(name)
            TextField("Enter Text", text: $name)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .padding(12)
            
            Button(action: printName, label: {
                Text("Show Name Value")
            })
        }
            
    }
    
    func printName(){
        print(self.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
