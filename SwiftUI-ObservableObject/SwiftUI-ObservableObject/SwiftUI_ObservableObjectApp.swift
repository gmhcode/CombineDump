//
//  SwiftUI_ObservableObjectApp.swift
//  SwiftUI-ObservableObject
//
//  Created by Greg Hughes on 10/20/20.
//

import SwiftUI

@main
struct SwiftUI_ObservableObjectApp: App {
    let userSettings = UserSettings()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userSettings)
        }
    }
}
