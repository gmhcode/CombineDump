//
//  ContentView.swift
//  Hello-SwiftUI
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            
            Image("costa-rica")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .padding(.all)
//                .clipShape(Circle())
            
            
            Text("First line")
                .font(.largeTitle)
            Text("Second Line")
                .font(.title)
                .foregroundColor(.green)
            
            HStack{
                Text("Left Side")
                Text("Right Side")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
