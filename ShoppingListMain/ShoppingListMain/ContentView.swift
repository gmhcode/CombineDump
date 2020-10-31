//
//  ContentView.swift
//  ShoppingListMain
//
//  Created by Greg Hughes on 10/23/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var listVM = ListViewModel()
    
    var body: some View {
        var color = 0.0
        List(listVM.lists) { list in
            ListCell(title: list.title, brightness: color).onAppear(perform: {
                    color -= 0.08
                    print(color)
                }).cornerRadius(10)
            }
            .onAppear(perform: {
                UITableView.appearance().separatorColor = .clear
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//http://192.168.1.43:8081/items
class Listi: Codable, Identifiable {
    
    
    let uuid : String
    let title: String
    let listMasterID : String
    
    init(uuid: String, title: String, listMasterID: String) {
        self.uuid = uuid
        self.title = title
        self.listMasterID = listMasterID
    }
    
    
   
}
//let theLists = [Listi(uuid: UUID().uuidString, name: "Gregs List", listMasterID: "Greg"),Listi(uuid: UUID().uuidString, name: "Miriam's List", listMasterID: "Miriam"),Listi(uuid: UUID().uuidString, name: "Jiraiya's List", listMasterID: "Jiraiya"),Listi(uuid: UUID().uuidString, name: "Gregs List", listMasterID: "Greg"),Listi(uuid: UUID().uuidString, name: "Miriam's List", listMasterID: "Miriam"),Listi(uuid: UUID().uuidString, name: "Jiraiya's List", listMasterID: "Jiraiya"),Listi(uuid: UUID().uuidString, name: "Gregs List", listMasterID: "Greg"),Listi(uuid: UUID().uuidString, name: "Miriam's List", listMasterID: "Miriam"),Listi(uuid: UUID().uuidString, name: "Jiraiya's List", listMasterID: "Jiraiya"),Listi(uuid: UUID().uuidString, name: "Gregs List", listMasterID: "Greg"),Listi(uuid: UUID().uuidString, name: "Miriam's List", listMasterID: "Miriam"),Listi(uuid: UUID().uuidString, name: "Jiraiya's List", listMasterID: "Jiraiya")]
