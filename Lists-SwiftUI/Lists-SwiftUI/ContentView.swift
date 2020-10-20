//
//  ContentView.swift
//  Lists-SwiftUI
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var tasks = [Task]()
    
    func addTask() {
        self.tasks.append(Task(name: "Wash the car"))
    }
    
    var body: some View {
        List {
            Button(action: addTask) {
                Text("Add Task")
                
            }
            ForEach(tasks) {task in
                Text(task.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
