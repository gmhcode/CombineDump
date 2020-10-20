//
//  ContentView.swift
//  stateToFilter
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    
    var model = Dish.all()
    @State var isSpicy = false
    
    var body: some View {
        List {
            
            Toggle(isOn: $isSpicy, label: {
                Text("Spicy")
                    .font(.title)
            })
            
            ForEach(model.filter{$0.isSpicy == self.isSpicy}) { dish in
                HStack {
                    Image(dish.imageURL)
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(dish.name)
                        .font(.title)
                        .lineLimit(nil)
                    
                    Spacer()
                    if dish.isSpicy {
                        Image("spicy-icon")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
