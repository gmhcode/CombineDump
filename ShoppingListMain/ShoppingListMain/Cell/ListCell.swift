//
//  ListCell.swift
//  ShoppingListMain
//
//  Created by Greg Hughes on 10/24/20.
//

import SwiftUI

struct ListCell: View {
    let title : String
    let brightness : Double
    var body: some View {
        
        VStack {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(title)
                        .lineLimit(2)
                        .padding(10)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                }
                Spacer()
                Text("6")
                    .padding(.trailing,10)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .foregroundColor(Color.white)
                
            }.frame(height: 80, alignment: .center)
            .background(Color.blue.brightness(brightness))
          
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 5)
            )
        }
    }
}


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(title: "Title", brightness: 0)
    }
}

struct SliderView: View {
    @State private var titleLength: CGFloat = 1
    
    var body: some View {
        Text(String.init(repeating: "T", count: Int(self.titleLength)))
        Text("Title length")
        Slider(value: $titleLength, in: 1...100) {
            // This Text is for Accessibility
            Text("Title")
        }
    }
}

//HStack {
//    Text("Title length")
//    Slider(value: $titleLength, in: 1...40) {
//        Text(String.init(repeating: "T", count: Int(self.titleLength)))
//    }
//}
//HStack {
//    Text("Subtitle length")
//    Slider(value: $subtitleLength, in: 1...100) {
//        Text(String.init(repeating: "S", count: Int(self.titleLength)))
//    }
//}
