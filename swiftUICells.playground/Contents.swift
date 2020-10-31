import SwiftUI
import PlaygroundSupport

var str = "Hello, playground"
struct Cell1: View {
  var body: some View {
    HStack {
      Image(systemName: "music.house")
      VStack {
        Text("Title")
        Text("Subtitle")
      }
    }
  }
}
PlaygroundPage.current.setLiveView(Cell1())
